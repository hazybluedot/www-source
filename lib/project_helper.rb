# encoding: utf-8

require 'squee'
require 'summarize'
require 'set'
require 'uri'

module Nanoc::Helpers
  module ProjectHelper 

    include ::ECE2524::Projects

    def record_for(pid)
      record = @site.roster.find_by([ :id, :gituser ] , /\b#{pid}\b/)
      record
      #@site.roster.records.select { |r| r.pid == pid }
    end
    
    def name_of(pid)
      record = record_for(pid)
      #record.each do |r|
      #  $stderr.puts "record: #{r.data.inspect}"
      #end
      record.first.nil? ? nil : record.first.data[:roster]["Name"].split(',').reverse.join(' ') 
    end
    
    def blog_of(pid)
      $stderr.puts "Looking up blog for #{pid}" if pid =~ /bk201/i
      record = record_for(pid)
      $stderr.puts "Found record #{record.first.data.inspect} for #{pid}" if pid =~ /bk201/i
      feed_url = record.first ? record.first.data[:feeds] : nil
      syndicates.select { |s| s[:feed_url] =~ /eceunix\.tumblr\.com/ }.each { |s| "feed: puts s.inspect" }
      post = feed_url ? syndicates.select { |s| s[:feed_url] && Regexp.new(Regexp.escape(s[:feed_url])) =~ feed_url }.first : nil
      post ? post[:author_uri] : nil
    end

    def byline_for(pid)
      name = name_of(pid) || pid
      blog = blog_of(pid)
      blog ? link_to(name, blog) : name
    end

    def no_description
      "Please add a summary paragraph. See #{link_to('formatting instructions', '/activities/project_proposal/')}</a>."
    end

    def project_tag_for(p)
      begin
        uri = URI(p[:url])
        tag_for(uri.path.sub(/^\//,"").sub('.git',''))
      rescue
        nil
      end
    end

    def project_link(tag_or_project)
      project = Nanoc::Item === tag_or_project ? tag_or_project : grouped_projects.find { |p| project_tag_for(p) == tag_or_project }
      project ?  homepage_for(project, project[:title]) : nil
    end

    def reviews
      @items.select { |i| %r!^/reviews/! =~ i.identifier }
    end

    def reviews_for(p)
      reviews.select{ |i| i[:tag] == project_tag_for(p) }
    end

    def review_author(r)
      pid = r.identifier.split('/')[2]
      #$stderr.puts "review #{r.identifier} author is #{pid}"
      byline_for(pid)
    end

    def content_count(nodeset)
      return 0 if nodeset.nil?
      return nodeset.first.content.length unless nodeset.children.any?
      nodeset.inject(0) { |count, n| count + content_count(n) }
    end

    def first_paragraph(content)
      doc = Nokogiri::HTML.fragment(content)
      summary = Nokogiri::HTML.fragment("")
      doc.children.each do |n| 
        if summary.content.length < 500
          summary.add_child(n)
        else
          break
        end
      end
      summary.content.length > 0 ? summary.to_html : no_description
    end

    def description_summary(post)
      content = post.compiled_content
      content =~ /^\s*<!-- more -->\s*/ ? content.partition(/^\s*<!-- more -->\s*/).first : first_paragraph(content)
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
      #@sorted_projects ||= 
      grouped_projects.sort_by { |p| reviews_for(p).count }.select { |p| p.identifier =~ /s14/ }
      #grouped_projects.select { |p| p.identifier =~ /s14/ }
    end

    def homepage_for(p, title=nil)
      p[:url] ? link_to(title ? title : 'Homepage', p[:url]) : nil
    end

    def grouped_projects
      blk = lambda do
        #projects.group_by { |p| p[:title] }
        projects.collect do |p|
          unless p[:contributors].respond_to? 'any?'
            p[:contributors] = p[:contributors].nil? ? [] : p[:contributors].split(",")
          end
        end
        projects.select { |p| p[:contributors].any? }.group_by { |p| Set.new(p[:contributors]) }.collect { |contribs,ps| ps.sort_by { |p| p[:title] }.first }
            #unless p.raw_content.nil?
            #  grep_count(/^\s*<!-- more -->\s*/, p.raw_content) 
            #else
            #  [1]
            #end
          #end.first }
      end

      if @items.frozen?
        @grouped_project_items ||= blk.call
      else
        blk.call
      end
    end
  end
end

def print_project(p)
  $stderr.puts "nil raw content for
title: #{p[:title]}
contributors: #{p[:contributors]}
url: #{p[:url]}

#{p.raw_content}
"           
end

include Nanoc::Helpers::ProjectHelper
