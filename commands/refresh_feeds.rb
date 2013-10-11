usage 'refresh_feeds'
aliases :refresh_feeds
description 'Read list of feed URLs and update local links'

require 'uri'
require 'stringex'
require 'typhoeus'

class RefreshFeeds < Nanoc::CLI::CommandRunner
  def run
    #self.require_site
    
    # Set VCS if possible
    #self.set_vcs(options[:vcs])

    arguments.each do |file_name|
      concurrent_fetch(file_name)
    end
  end
  
  def concurrent_fetch(file_name)
    hydra = Typhoeus::Hydra.new
    feeds = {}
    if File.readable?(file_name)
      File.open(file_name).each do |uri|
        r = Typhoeus::Request.new(uri, followlocation: true)
        r.on_complete do |response|
          feed_url = URI(r.url)
          feed_dir = File.dirname(File.join(Dir.pwd, "feeds", feed_url.host.gsub('.','_'), feed_url.path))
          Dir.exists?(feed_dir) ? nil : FileUtils.mkdir_p(feed_dir)
          file_path = File.join(File.realpath(feed_dir), 'feed.xml')
          File.open(file_path, 'w+') { |file| file.write(response.body) }
        end
        hydra.queue r
      end
      hydra.run
    else
      $stderr.puts file_name+': Could not open file'
    end
  end
end

runner RefreshFeeds
