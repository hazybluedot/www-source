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

    arguments.each do |file_name|
      if File.readable?(file_name)
        File.open(file_name).each do |uri|
          feed = Feedzirra::Feed.fetch_and_parse(uri)
          puts feed.title
          feed.entries.each do |entry|
            #entry.sanitize!
            entry_url = URI(entry.url)
            host = entry_url.host
            path_parts = entry_url.path.split("/")
            identifier = "/syndicated/" + host.gsub('.','_') + "/" + path_parts[1] + "/" + path_parts[2..-1].join("-") + "/"

            exists = @site.items.find { |i| i.identifier == identifier }
            if exists
              puts "Item " + exists[:title] + " already exists... TODO: check for update"
            else
              meta = {
                :title => entry.title,
                :entry_url => entry.url,
                :kind => 'syndicate',
                :created_at => entry.published,
                :author_name => entry.author || path_parts[1],
                :author_uri => feed.url,
                :tags => entry.categories
              }

              puts "\t creating item "+ identifier
              puts "\t with meta data: " + meta.inspect
              
              #create post if it doesn't exist
              data_source = self.site.data_sources[0]
              data_source.create_item(
                                      entry.content,
                                      meta,
                                      identifier,
                                      { :extension => '.html' }
                                      )
            end
          end
        end
      else
        p file_name+': Could not open file'
      end
    end
  end
end

runner RefreshFeeds
