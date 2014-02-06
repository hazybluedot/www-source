# encoding: utf-8

require 'nokogiri'
require 'uri'

module Nanoc::Filters
  class CommandCodeSyntax < Nanoc::Filter
    identifier :command_code
    type :text
    requires 'nokogiri'
    requires 'uri'
    
    def split_content(content)
      return [content] unless content.match(@tag_regex)
      pre, tag, post = content.partition(@tag_regex)
      post = split_content(post)
      [ pre, tag, post ].flatten
    end
    
    def nodify(doc, content_array)
      return Nokogiri::XML::NodeSet.new(doc) unless content_array.respond_to? :collect
      nodes = content_array.collect do |c| 
        node = Nokogiri::XML::Text.new(c, doc)
        c.match(@tag_regex) do |m|
          node = Nokogiri::XML::Node.new("span", doc)
          node["class"] = "user-substitution"
          node.content = "#{$1}"
          node
        end
        node
      end
      return Nokogiri::XML::NodeSet.new(doc, nodes)
    end

    def explain_shell(doc, node)
      return node unless node.content.match(/^\$ (.*)$/)
      span = Nokogiri::XML::Node.new("span", doc)
      span["class"] = "explain-shell"
      exp = Nokogiri::XML::Node.new("a", doc)
      exp["href"] = "http://explainshell.com/explain?cmd=#{URI.escape($1)}"
      exp.content = "explain"
      pre, tag, post = span.content.partition(/^\$ (.*)$/)
      span << Nokogiri::XML::Text.new("# ", doc) << exp
      if node.css('span.go').find_all.any?
        nodes = Nokogiri::XML::NodeSet.new(doc, [ span, Nokogiri::XML::Text.new("\n", doc) ])
        first_go = node.css('span.go').find_all.first
        first_go.previous_sibling.remove
        first_go.add_previous_sibling(nodes)        
      else
        node << span
      end
      #node.add_child(span)
      node
    end

    def user_input(node)
      node.css('span.go').find_all.select { |c| c.content[0] == ':' }.each do |c| 
        c["class"] = "user-input" 
        c.content = c.content.gsub(/^:(.*)$/, '\1')
      end
    end

    def run(content, options)
      @tag_regex = Regexp.new('<([^>]+)>')
      doc = Nokogiri::HTML(content)
      doc.css('pre.command-syntax code').find_all do |pre|
        text_nodes = split_content(pre.content)
        pre.content = ''
        pre.add_child nodify(doc, text_nodes)
      end
      doc.css('pre:not(.no-explain) code.language-console').find_all do |code|
        explain_shell(doc, code)
      end
      doc.css('code.language-console').find_all do |code|
        user_input(code)
      end
      doc.to_html
    end
  end
end
