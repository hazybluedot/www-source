# encoding: utf-8

module Nanoc::DataSources

  class ProjectReviews < Nanoc::DataSource
    identifier :project_reviews

    include Nanoc::DataSources::Filesystem

    def items
      load_objects('repos', 'item', Nanoc::Item)
    end

    def layout
      []
    end

    def sync
      return if config.has_key? :active && !config[:active]
      config[:repos_root] = 'repos'
      config[:git_url] = 'ece2524git@ece2524.ece.vt.edu'
      system("git pull", :chdir => 'user-data/push_logs/')
      File.open('user-data/push_logs/project_reviews.log').collect { |line| line.split(' ').first }.uniq.compact.each do |repo|
        repodir = File.join(config[:repos_root], repo)
        gitdir = File.join(repodir, '.git')
        if Dir.exists?(gitdir)
          system("git pull origin master", :chdir => repodir)
        else
          system("git clone #{config[:git_url]}:#{repo}.git #{repodir}")
        end
      end
    end

    protected

    def all_files_in(dir_name)
      Nanoc::Extra::FilesystemTools.all_files_in(dir_name).select { |f|  %r!.*/REVIEW.*$! =~ f }
    end

    private
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

    # Returns the identifier derived from the given filename, first stripping
    # the given directory name off the filename.
    def identifier_for_filename(filename)
      filename = filename.split(File::SEPARATOR).reject { |f| /(reviews|REVIEW)/ =~ f }.join(File::SEPARATOR)
      if filename =~ /(^|\/)index(\.[^\/]+)?$/
        regex = @config && @config[:allow_periods_in_identifiers] ? /\/?(index)?(\.[^\/\.]+)?$/ : /\/?index(\.[^\/]+)?$/
      else
        regex = @config && @config[:allow_periods_in_identifiers] ? /\.[^\/\.]+$/ : /\.[^\/]+$/
      end
      filename.sub(regex, '').cleaned_identifier
    end
  end
end
