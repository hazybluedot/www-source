# encoding: utf-8

module ECE2524Site
  
  class CodeSnippetFilter < Nanoc::Filter
    identifier :snippet
    def run(content, params={})
      snipex = /\[\[snippet:([^\]]*)\]\]/
      doc = Nokogiri::HTML(content)
      doc.css('p').find_all { |n| n.content =~ snipex }.each do |p|
        p.content.match(snipex) do |m|
          node = Nokogiri::HTML.fragment(code_snippet($1))
          p.replace node
        end
      end
      #content.gsub(/<p>\s*\[\[snippet:([^\]]*)\]\]\s*<\/p>/) do
      #  code_snippet($1)
      #end
      doc.to_html
    end
  end

end
