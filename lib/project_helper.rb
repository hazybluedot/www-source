# encoding: utf-8

require 'squee'
require 'summarize'
require 'set'

module Nanoc::Helpers
  module ProjectHelper 

    include ::ECE2524::Projects

    def record_for(pid)
      @site.roster.find(pid)
      #@site.roster.records.select { |r| r.pid == pid }
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

    def no_description
      "Please add a summary paragraph. See #{link_to('formatting instructions', '/activities/project_proposal/')}</a>."
    end

    def project_tag_for(p)
      tag_for(p[:title])
    end

    def project_link(tag_or_project)
      project = Nanoc::Item === tag_or_project ? tag_or_project : grouped_projects.find { |p| p[:tag] == tag_or_project }
      project ?  homepage_for(project, project[:title]) : nil
    end

    def reviews
      @items.select { |i| %r!^/reviews/! =~ i.identifier }
    end

    def reviews_for(p)
      reviews.select{ |i| i[:tag] == p[:tag] }
    end

    def review_author(r)
      pid = r.identifier.split('/')[2]
      #$stderr.puts "review #{r.identifier} author is #{pid}"
      byline_for(pid)
    end

    def description_summary(post)
      content = post.compiled_content
      $stderr.puts "Found a summary for #{post[:title]}" if /^\s*<!-- more -->\s*/ =~ content
      content =~ /^\s*<!-- more -->\s*/ ? content.partition(/^\s*<!-- more -->\s*/).first : no_description
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

    def sorted_projects
      grouped_projects.sort_by { |p| reviews_for(p).count }
    end

    def homepage_for(p, title=nil)
      p[:url] ? link_to(title ? title : 'Homepage', p[:url]) : nil
    end

    def grep_count(expression, multiline)
      count = multiline.split('\n').collect do |line|
        expression =~ line
      end.count
      #$stderr.puts "Found #{count} lines matching more thing"
      count
    end

    def grouped_projects
      blk = lambda do
        #projects.group_by { |p| p[:title] }
        projects.select { |p| p[:contributors].any? }.group_by { |p| Set.new(p[:contributors]) }.collect { |contribs,ps| ps.sort_by{ |p| grep_count(/^\s*<!-- more -->\s*/, p.raw_content) }.first }
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
