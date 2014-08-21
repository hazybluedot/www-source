# -*- coding: utf-8 -*-
module Nanoc::DataSources
  class FileGlob < Nanoc::DataSource
    identifier :file_glob
    
    def items
      load_items(config[:path])
    end
    
    def layout
      nil
    end

    def load_items(dir_name)
      items = all_split_files_in(dir_name, config[:glob]).map do |base_filename, (meta_ext, content_ext)|
        # Get filenames
        meta_filename    = filename_for(base_filename, meta_ext)
        content_filename = filename_for(base_filename, content_ext)

        # Read content and metadata
        is_binary = !!(content_filename && !@site.config[:text_extensions].include?(File.extname(content_filename)[1..-1]))
        is_binary = false
        #if is_binary
        #  $stderr.puts "OMGWTFBBQ: #{base_filename} is binary!"
        #  meta                = (meta_filename && YAML.load_file(meta_filename)) || {}
        #  content_or_filename = content_filename
        #else
        begin
          meta, content_or_filename = parse(content_filename, meta_filename, 'item')
        rescue RuntimeError => e
            $stderr.puts "Could not parse #{base_filename}: #{e}"
            nil
        else
          # Get attributes
          attributes = {
            :filename         => content_filename,
            :content_filename => content_filename,
            :meta_filename    => meta_filename,
            :extension        => content_filename ? ext_of(content_filename)[1..-1] : nil,
            # WARNING :file is deprecated; please create a File object manually
            # using the :content_filename or :meta_filename attributes.
            # TODO [in nanoc 4.0] remove me
            :file             => content_filename ? Nanoc::Extra::FileProxy.new(content_filename) : nil
          }.merge(meta)
          
          # Get identifier
          if meta_filename
            identifier = identifier_for_filename(meta_filename[(dir_name.length+1)..-1])
          elsif content_filename
            identifier = identifier_for_filename(content_filename[(dir_name.length+1)..-1])
          else
            raise RuntimeError, "meta_filename and content_filename are both nil"
          end

          # Get modification times
          meta_mtime    = meta_filename    ? File.stat(meta_filename).mtime    : nil
          content_mtime = content_filename ? File.stat(content_filename).mtime : nil
          if meta_mtime && content_mtime
            mtime = meta_mtime > content_mtime ? meta_mtime : content_mtime
          elsif meta_mtime
            mtime = meta_mtime
          elsif content_mtime
            mtime = content_mtime
          else
            raise RuntimeError, "meta_mtime and content_mtime are both nil"
          end
          
          Nanoc::Item.new(
                          content_or_filename, attributes, identifier,
                          :binary => is_binary, :mtime => mtime
                          )
        end
      end.compact
    end

    # Finds all items/layouts/... in the given base directory. Returns a hash
    # in which the keys are the file's dirname + basenames, and the values a
    # pair consisting of the metafile extension and the content file
    # extension. The meta file extension or the content file extension can be
    # nil, but not both. Backup files are ignored. For example:
    #
    #   {
    #     'content/foo' => [ 'yaml', 'html' ],
    #     'content/bar' => [ 'yaml', nil    ],
    #     'content/qux' => [ nil,    'html' ]
    #   }
    def all_split_files_in(dir_name, glob)
      # Get all good file names
      filenames = self.all_globs_in(dir_name, glob)
      filenames.reject! { |fn| fn =~ /(~|\.orig|\.rej|\.bak)$/ }

      # Group by identifier
      grouped_filenames = filenames.group_by { |fn| basename_of(fn) }

      # Convert values into metafile/content file extension tuple
      grouped_filenames.each_pair do |key, filenames|
        # Divide
        meta_filenames    = filenames.select { |fn| ext_of(fn) == '.yaml' }
        content_filenames = filenames.select { |fn| ext_of(fn) != '.yaml' }

        # Check number of files per type
        if ![ 0, 1 ].include?(meta_filenames.size)
          raise RuntimeError, "Found #{meta_filenames.size} meta files for #{key}; expected 0 or 1"
        end
        #if ![ 0, 1 ].include?(content_filenames.size)
        #  raise RuntimeError, "Found #{content_filenames.size} content files for #{key}; expected 0 or 1"
        #end

        # Reorder elements and convert to extnames
        filenames[0] = meta_filenames[0]    ? 'yaml'                                   : nil
        filenames[1] = content_filenames[0] ? ext_of(content_filenames[0])[1..-1] || '': nil
      end

      # Done
      grouped_filenames
    end

    # Returns all files in the given directory and directories below it.
    def all_globs_in(dir_name, glob)
      $stderr.puts "globbing #{dir_name}#{glob}"
      Dir[dir_name + glob].map do |fn|
        case File.ftype(fn)
        when 'link'
          if 0 == recursion_limit
            raise MaxSymlinkDepthExceededError.new(fn)
          else
            absolute_target = self.resolve_symlink(fn)
            if File.file?(absolute_target)
              fn
            else
              all_files_in(absolute_target, recursion_limit-1).map do |sfn|
                fn + sfn[absolute_target.size..-1]
              end
            end
          end
        when 'file'
          fn
        when 'directory'
          nil
        else
          raise UnsupportedFileTypeError.new(fn)
        end
      end.compact.flatten
    end

    # See {Nanoc::DataSources::Filesystem#filename_for}.
    def filename_for(base_filename, ext)
      if ext.nil?
        nil
      elsif ext.empty?
        base_filename
      else
        base_filename + '.' + ext
      end
    end

    def my_strip(string, chars)
      chars = Regexp.escape(chars)
      string.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "").strip
    end

    def fixyaml(content)
      content.each_line.collect do |line|
        key,part,value = line.partition(":")
        part.gsub!(/:\s*/, ": ")
        value.rstrip!
        if value.include? ":"
          value = "\"#{my_strip(value.strip, '"\'')}\""
        end
        if key == 'contributors'
          #if value =~ /\w+,\s*(\w+(,\s*)?)+/
          value = my_strip(value.strip, "[]")
          value = "[ #{value} ] "
        end
        "#{key}#{part}#{value}"
      end.join("\n")
    end
    # Returns the identifier derived from the given filename, first stripping
    # the given directory name off the filename.
    def identifier_for_filename(filename)
      if filename =~ /(^|\/)index(\.[^\/]+)?$/
        regex = ((@config && @config[:allow_periods_in_identifiers]) ? /\/?(index)?(\.[^\/\.]+)?$/ : /\/?index(\.[^\/]+)?$/)
      else
        regex = ((@config && @config[:allow_periods_in_identifiers]) ? /\.[^\/\.]+$/         : /\.[^\/]+$/)
      end
      filename.sub(regex, '').cleaned_identifier
    end

    # Returns the base name of filename, i.e. filename with the first or all
    # extensions stripped off. By default, all extensions are stripped off,
    # but when allow_periods_in_identifiers is set to true in the site
    # configuration, only the last extension will be stripped .
    def basename_of(filename)
      filename.sub(extension_regex, '')
    end

    # Returns the extension(s) of filename. Supports multiple extensions.
    # Includes the leading period.
    def ext_of(filename)
      filename =~ extension_regex ? $1 : ''
    end

    # Returns a regex that is used for determining the extension of a file
    # name. The first match group will be the entire extension, including the
    # leading period.
    def extension_regex
      if @config && @config[:allow_periods_in_identifiers]
        /(\.[^\/\.]+$)/
      else
        /(\.[^\/]+$)/
      end
    end

    # Parses the file named `filename` and returns an array with its first
    # element a hash with the file's metadata, and with its second element the
    # file content itself.
    def parse(content_filename, meta_filename, kind)
      # Read content and metadata from separate files
      if meta_filename
        content = content_filename ? read(content_filename) : ''
        meta_raw = read(meta_filename)
        begin
          meta = YAML.load(meta_raw) || {}
        rescue Exception => e
          raise "Could not parse YAML for #{meta_filename}: #{e.message}"
        end
        return [ meta, content ]
      end

      # Read data
      data = read(content_filename)

      # Check presence of metadata section
      if data !~ /\A-{3,5}\s*$/
        return [ {}, data ]
      end

      # Split data
      pieces = data.split(/^(-{5}|-{3})\s*$/)
      if pieces.size < 4
        raise RuntimeError.new(
          "The file '#{content_filename}' appears to start with a metadata section (three or five dashes at the top) but it does not seem to be in the correct format."
        )
      end

      # Parse
      begin
        meta = YAML.load(pieces[2]) || {}
      rescue Exception => e
        raise "Could not parse YAML for #{content_filename}: #{e.message}"
      end
      content = pieces[4..-1].join.strip

      # Done
      [ meta, content ]
    end

    # Reads the content of the file with the given name and returns a string
    # in UTF-8 encoding. The original encoding of the string is derived from
    # the default external encoding, but this can be overridden by the
    # “encoding” configuration attribute in the data source configuration.
    def read(filename)
      # Read
      begin
        data = File.read(filename)
      rescue => e
        raise RuntimeError.new("Could not read #{filename}: #{e.inspect}")
      end

      # Fix
      if data.respond_to?(:encode!)
        if @config && @config[:encoding]
          original_encoding = Encoding.find(@config[:encoding])
          data.force_encoding(@config[:encoding])
        else
          original_encoding = data.encoding
        end

        data.encode!('UTF-8') rescue raise_encoding_error(filename, original_encoding)
        raise_encoding_error(filename, original_encoding) if !data.valid_encoding?
      end

      # Remove UTF-8 BOM (ugly)
      data.gsub!("\xEF\xBB\xBF", '')

      data
    end

    # Raises an invalid encoding error for the given filename and encoding.
    def raise_encoding_error(filename, encoding)
      raise RuntimeError.new("Could not read #{filename} because the file is not valid #{encoding}.")
    end

  end  
end
