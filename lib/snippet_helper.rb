# encoding: utf-8

module SnippetHelper
  def lexer_for_mime(mime_type)
    case
    when mime_type.match(/python/)
      'python'
    when mime_type.match(/ruby/)
      'ruby'
    else
      'text'
    end
  end

  def lexer_by_ext(fname)
    case File.extname(fname)
    when '.yaml'
      'yaml'
    when '.json'
      'json'
    when '.rb'
      'ruby'
    else
      'text'
    end
  end

  def code_snippet(fname)
    prefix = config[:prefix] || 'snippets'
    item_id = '/' + File.join(prefix,fname) + '/'
    snippet = @site.items.find{ |item| item.identifier == item_id }
    if snippet
      lexer = lexer_for_mime(snippet[:mime_type])
      lexer = lexer_by_ext(fname) if lexer == 'text'
      render 'snippet', :code=>snippet.compiled_content, :lexer => lexer, :file_name => fname, :snippet => snippet
    else
      $stderr.puts fname + ": could not find snippet"
    end
  end
end

include SnippetHelper
