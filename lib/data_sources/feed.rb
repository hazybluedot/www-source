require 'feedzirra'

module Feedzirra::Parser
  class RSS
    element :'atom:link', :value => :href, :as => :feed_url
  end
end

module Nanoc::DataSources
  Feedzirra::Feed.add_common_feed_entry_element('category', :as => :category)
  Feedzirra::Feed.add_common_feed_entry_element('dc:creator', :as => :creator)
  Feedzirra::Feed.add_common_feed_entry_element('slash:comments', :as => :comment_count)
  Feedzirra::Feed.add_common_feed_entry_element('comments', :as => :comment_url)
  
  class Feeds < Nanoc::DataSource
    identifier :feeds
    
    # Get prefix. not sure if this is the appropriate place for this
    def up
      @prefix = config[:prefix] || 'feeds'
      @syndicate_since = Time.parse(config[:syndicate_since] || 'Jan 01 00:00:01 GMT 1969')
    end

    def items
      items = []
      # Get all files under prefix dir
      get_feeds(@prefix).each do |feed|
        items.concat(read_entries(feed))
      end
      items
    end
    
    def sync
      require 'uri'
      require 'stringex'
      require 'typhoeus'

      feeds_source = File.join(Dir.pwd, config[:feeds_source])
      concurrent_fetch(read_urls feeds_source)
    end

    def comments
      #prefix = config[:prefix] || 'feeds'
      Feedzirra::Feed.add_common_feed_entry_element('wfw:commentRss', :as => :comment_feed)
      #get_feeds(@prefix).each do |feed|
      #  
      #end
    end

    protected
    
    def get_feeds(prefix)
      feeds = []
      self.all_files_in(prefix).map do |filename|
        File.open(filename,'r') do |file| 
          begin
            feeds.push(Feedzirra::Feed.parse(file.read()))
          rescue Feedzirra::NoParserAvailable => e
            $stderr.puts 'Error: ' + file.path
          end
        end
      end
      return feeds
    end
    
    def read_entries(feed)
      items = []
      
      warn "No feed_url for #{feed.url}" if feed.feed_url.nil?

      feed.entries.select { |e| (e.published > @syndicate_since) && !((e.content || '') =~ /This is your first post\./) }.each do |entry|
        #entry.sanitize!
        entry_url = URI(entry.url)
        path_parts = entry_url.path.split("/")
        entry.creator = path_parts[1] unless entry.creator
        identifier = "/syndicated/" + entry_url.host.gsub('.','_') + "/" + entry.creator + "/" + path_parts[2..-1].join("-").gsub('.','_') + "/"

        $stderr.puts "Found category: #{feed.category}" if entry.category

        meta = {
          :title => entry.title,
          :feed_url => feed.feed_url,
          :entry_url => entry.url,
          :kind => 'syndicate',
          :created_at => entry.published,
          :author_name => entry.author || entry.creator,
          :author_uri => feed.url,
          :tags => entry.categories,
          :comment_count => entry.comment_count,
          :published => true
        }

        begin
          items << Nanoc::Item.new(
                                   entry.content,
                                   meta,
                                   identifier,
                                   :binary => false
                                   )
        rescue RuntimeError => e
          $stderr.puts identifier + ":" + e.to_s
        end
      end
      items
    end
    
    def concurrent_fetch(uris)
      hydra = Typhoeus::Hydra.new
      feeds = {}
      uris.each do |uri|
        r = Typhoeus::Request.new(uri, followlocation: true)
        r.on_complete do |response|
          $stderr.puts "Fetched #{r.url}"
          feed_url = URI(r.url)
          feed_dir = File.dirname(File.join(Dir.pwd, config[:feeds_root], feed_url.host.gsub('.','_'), feed_url.path))
          Dir.exists?(feed_dir) ? nil : FileUtils.mkdir_p(feed_dir)
          file_path = File.join(File.realpath(feed_dir), 'feed.xml')
          File.open(file_path, 'w+') { |file| file.write(response.body) }
        end
        hydra.queue r
      end
      hydra.run
    end

    def read_urls(file_name)
      if File.readable?(file_name)
        File.open(file_name).collect { |line| (line).slice(URI.regexp) }.select { |uri| uri }
      else
        []
      end
    end

    def all_files_in(dir_name)
      Nanoc::Extra::FilesystemTools.all_files_in(dir_name)
    end
    
  end
  
end
