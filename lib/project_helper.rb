# encoding: utf-8

require 'squee'
require 'summarize'
require 'set'

module Nanoc::Helpers
  module ProjectHelper 
    def tag_for(string)
      string.downcase.gsub(' ', '_').tr('^a-z0-9_', '')
    end
    
    def record_for(pid)
      @site.roster.records.select { |r| r.pid == pid }
    end
    
    def name_of(pid)
      record = record_for(pid)
      #record.each do |r|
      #  $stderr.puts "record: #{r.data.inspect}"
      #end
      record.first ? record.first.data[:roster]["Name"].split(',').reverse.join(' ') : "" 
    end
    
    def blog_of(pid)
      record = record_for(pid)
      feed_url = record.first ? record.first.data[:feeds] : nil
      post = feed_url ? syndicates.select { |s| s[:feed_url] && Regexp.new(Regexp.escape(s[:feed_url])) =~ feed_url }.first : nil
      post ? post[:author_uri] : nil
    end

    def byline_for(pid)
      name = name_of(pid)
      blog = blog_of(pid)
      blog ? link_to(name, blog) : name
    end

    def description_summary(post)
      content = post.compiled_content
      content =~ /\s<!-- more -->\s/ ? content.partition('<!-- more -->').first : "Please add a summary paragraph"
    end

    def contributors_for(p)
      p[:contributors] || []
    end

    def projects
      blk = lambda  { @site.items.select { |item| /^\/projects\/.*\// =~ item.identifier } }

      if @site.items.frozen?
        @project_items ||= blk.call
      else
        blk.call
      end
    end

    def homepage_for(p)
      p[:url] ? link_to('Homepage', p[:url]) : nil
    end

    def grouped_projects
      blk = lambda do
        #projects.group_by { |p| p[:title] }
        projects.group_by { |p| Set.new(p[:contributors]) }.collect { |contribs,ps| ps.first }
      end

      if @items.frozen?
        @grouped_project_items ||= blk.call
      else
        blk.call
      end
    end
  end
end

include Nanoc::Helpers::ProjectHelper
