# encoding: utf-8

require 'mustache'

module Nanoc::Mustache

  class Filter < Nanoc::Filter

    identifier :mustache

    def run(content, params={})
      context = item.attributes.merge({ :yield => assigns[:content] })
      use = ::Mustache.render(params.key?(:content_layout) ? layout_content(params[:content_layout]) : content, context)
      $stderr.puts "rendered: #{use.lines[1..5].join('\n')}"
      use
    end

    private
    def layout_content(identifier)
      begin
        content = @site.layouts.find { |l| l.identifier == identifier }.raw_content
      rescue
        raise "Could not find layout '#{identifier}' in #{@site.layouts.collect { |l| l.identifier } } "
      end
    end
  end

end
