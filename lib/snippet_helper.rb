# encoding: utf-8

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
