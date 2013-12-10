$LOAD_PATH.unshift(File.expand_path('~/workspace/sqee/lib/'))
$LOAD_PATH.unshift(File.expand_path('~/workspace/ddplugin/lib/'))
require 'squee'

module Nanoc::DataSources

  class Projects < Nanoc::DataSource
    identifier :projects

    include ::ECE2524::Projects

    def up()
      squee_config = File.join(ENV['HOME'], 'ece2524/')
      @roster = ::Squee::Roster.new(squee_config)
      @site.roster = @roster
    end

    def items()
      projects = load_projects(@roster.records, @roster.config[:prefix])
      
      items = projects.group_by{ |p| p[:title] }.collect do |title,plist| 
        p = plist.first
        identifier = "/s13/#{tag_for(p[:title])}"
        meta = {
          :title => p[:title],
          :contributors => contributors_for(p),
          :url => p[:url]
        }
        
        p[:description] ? Nanoc::Item.new(p[:description],
                        meta,
                        identifier
                        ) : nil
      end.select { |i| !i.nil? }
      items
    end

    private
    
    def contributors_for(p)
      p[:contributors] ? p[:contributors].collect { |c| c.pid } : []
    end
  end
end

module Nanoc

  class Site
    attr_accessor :roster
  end

end
