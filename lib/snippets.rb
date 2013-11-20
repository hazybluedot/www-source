include Nanoc::Extra::FilesystemTools

module Nanoc::DataSources
  class Snippets < Nanoc::DataSource
    identifier :snippets

    def items
      prefix = config[:prefix] || 'snippets'
      self.all_files_in(prefix).map do |filename|
        meta = {
          :mime_type => `file -ib #{filename}`.gsub(/\n/,""),
        }
        identifier = filename[(prefix.length+1)..-1] + '/'
        Nanoc::Item.new(File.open(filename, 'r') { |io| io.read() },
                        meta,
                        identifier
                        )
      end
    end
    
    protected
    
    def all_files_in(dir_name)
      Nanoc::Extra::FilesystemTools.all_files_in(dir_name)
    end
  end
end

module SnippetHelper
  def lexer_for_mime(mime_type)
    case
    when mime_type.match(/python/)
      'python'
    else
      'text'
    end
  end

  def code_snippet(fname)
    prefix = config[:prefix] || 'snippets'
    item_id = '/' + File.join(prefix,fname) + '/'
    snippet = @site.items.find{ |item| item.identifier == item_id }
    if snippet
      render 'snippet', :code=>snippet.compiled_content, :mime_type => snippet[:mime_type], :file_name => fname, :snippet => snippet
    else
      $stderr.puts fname + ": could not find snippet"
    end
  end
end

include SnippetHelper
