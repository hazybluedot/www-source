usage 'refresh_feeds'
aliases :refresh_feeds
description 'Read list of feed URLs and update local links'

require 'feedzirra'
require 'uri'
require 'stringex'

class RefreshFeeds < Nanoc::CLI::Commands::CreateItem
  def run
    self.require_site
    
    # Set VCS if possible
    self.set_vcs(options[:vcs])

    Feedzirra::Feed.add_common_feed_entry_element('dc:creator', :as => :creator)

    arguments.each do |file_name|
      if File.readable?(file_name)
        File.open(file_name).each do |uri|
          feed = Feedzirra::Feed.fetch_and_parse(uri)
          if feed
            begin
              puts feed.title
              read_entries(feed)
            rescue Exception => e
              $stderr.puts 'Error: ' + uri
              $stderr.puts e.message
            end
          else
            $stderr.puts 'Error: ' + uri
          end
        end
      else
        $stderr.puts file_name+': Could not open file'
      end
    end
  end

  def read_entries(feed)
    syndicate_since = Time.parse(self.site.config[:syndicate_since] || 'Jan 01 00:00:01 GMT 1969')
    
    feed.entries.select { |e| (e.published > syndicate_since) && !((e.content || '') =~ /This is your first post\./) }.each do |entry|
      #entry.sanitize!
      entry_url = URI(entry.url)
      host = entry_url.host
      path_parts = entry_url.path.split("/")
      entry.creator = path_parts[1] unless entry.creator
      identifier = "/syndicated/" + host.gsub('.','_') + "/" + entry.creator + "/" + path_parts[2..-1].join("-").gsub('.','_') + "/"
      exists = @site.items.find { |i| i.identifier == identifier }
      entry.title = 'Untitled Post' unless entry.title
      print "\t" + entry.title
      if exists
        exists[:title] = 'Untitled' unless exists[:title]
        #puts "Item " + exists[:title] + " already exists... TODO: check for update"
        print ' (exists... TODO: check for update)'
      else
        meta = {
          :title => entry.title,
          :entry_url => entry.url,
          :kind => 'syndicate',
          :created_at => entry.published,
          :author_name => entry.author || entry.creator,
          :author_uri => feed.url,
          :tags => entry.categories
        }


        #create post if it doesn't exist
        data_source = self.site.data_sources[0]
        data_source.create_item(
                                entry.content,
                                meta,
                                identifier,
                                { :extension => '.html' }
                                )
        print ' (created)'
        
      end
      print "\n"
    end
  end
end

runner RefreshFeeds
