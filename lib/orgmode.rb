# encoding: utf-8

require 'org-ruby'

module Nanoc::Filters
  class Orgmode < Nanoc::Filter
    identifier :orgmode
    type :text
    requires 'org-ruby'

    # Runs the content through [org-ruby](http://orgmode.org/worg/org-tutorials/org-ruby.html).
    #
    # @param [String] content The content to filter
    #
    # @return [String] The filtered content
    def run(content, params={})
      # Get result
      ::Orgmode::Parser.new(content).to_html
    end

  end
end
