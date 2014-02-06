
require 'nokogiri'

module Nanoc::Filters
  class WhiteSpace < Nanoc::Filter
    identifier :vstrip
    type :text
    requires 'nokogiri'

    def is_blank?(node)
      # note, [[:space:]] will match a no-break space. #strip does not
      # remove no-break space so previous check of
      # node.content.strip=='' failed to result in <p> &nbsp; </p>
      # being removed
      (node.text? && node.content =~ /^[[:space:]]*$/ ) || (node.element? && node.name == 'br')
    end

    def all_children_are_blank?(node)
      node.children.all? { |child| is_blank?(child) }
    end
    
    def run(content, options)
      doc = Nokogiri::HTML(content)
      doc.css('p').find_all { |p| all_children_are_blank?(p) }.each do |p|
        p.remove
      end
      doc.to_html
    end
  end
end
