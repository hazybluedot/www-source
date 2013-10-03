module Nanoc::DataSources
  Feedzirra::Feed.add_common_feed_entry_element('dc:creator', :as => :creator)
  Feedzirra::Feed.add_common_feed_entry_element('slash:comments', :as => :comment_count)

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
    
    def comments
      #prefix = config[:prefix] || 'feeds'
      Feedzirra::Feed.add_common_feed_entry_element('wfw:commentRss', :as => :comment_feed)
      get_feeds(@prefix).each do |feed|
        
      end
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
      
      feed.entries.select { |e| (e.published > @syndicate_since) && !((e.content || '') =~ /This is your first post\./) }.each do |entry|
        #entry.sanitize!
        entry_url = URI(entry.url)
        path_parts = entry_url.path.split("/")
        entry.creator = path_parts[1] unless entry.creator
        identifier = "/syndicated/" + entry_url.host.gsub('.','_') + "/" + entry.creator + "/" + path_parts[2..-1].join("-").gsub('.','_') + "/"

        meta = {
          :title => entry.title,
          :entry_url => entry.url,
          :kind => 'syndicate',
          :created_at => entry.published,
          :author_name => entry.author || entry.creator,
          :author_uri => feed.url,
          :tags => entry.categories,
          :comment_count => entry.comment_count,
          :published => true
        }

        items << Nanoc::Item.new(
                        entry.content,
                        meta,
                        identifier,
                        :binary => false
                        )
      end
      items
    end
    
    def all_files_in(dir_name)
      Nanoc::Extra::FilesystemTools.all_files_in(dir_name)
    end
      
  end
  
end
