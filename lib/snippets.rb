include Nanoc::Extra::FilesystemTools

module Nanoc::DataSources
  class Snippets < Nanoc::DataSource
    identifier :snippets

    def up
      @prefix = config[:prefix] || 'snippets'
    end

    def items
      Nanoc::Extra::FilesystemTools.all_files_in(@prefix).map do |filename|
        meta = {
          :mime_type => `file -ib #{filename}`.gsub(/\n/,""),
        }
        Nanoc::Item.new(Fiele.open(filename, 'r') { |io| io.read() }
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
    file_path = File.join(File.expand_path(@config[:snippet_path]), fname)
    snippet = ""
    if File.exists?(file_path)
      mime_type = `file -ib #{file_path}`.gsub(/\n/,"")
      snippet = include_src(fname)
    end
    render 'snippet', :code=>snippet, :mime_type => mime_type, :file_name => fname
  end

  def include_src(fname)
    file_path = File.join(File.expand_path(@config[:snippet_path]), fname)
    if File.exists?(file_path)
      File.open(file_path, 'r') { |io| io.read() }
    end
  end
end

include SnippetHelper
