$LOAD_PATH.unshift(File.expand_path('~/workspace/sqee/lib/'))
$LOAD_PATH.unshift(File.expand_path('~/workspace/ddplugin/lib/'))
require 'squee'
require 'digest/sha1'
require 'set'

module Nanoc::DataSources

  class Projects < Nanoc::DataSource
    identifier :projects

    include ::ECE2524::Projects

    def up
      squee_config = File.join(ENV['HOME'], 'ece2524/')
      @roster = ::Squee::Roster.new(squee_config)
      @site.roster = @roster
    end

    def sync
      #require 'rugged'
      # TODO: get something prettier
      system("git-pull-all CREATOR/project repos/project_proposals/CREATOR", :chdir => File.join(ENV['HOME'], 'ece2524/'))
    end
    
    def items
      projects = load_projects(@roster.records, @roster.config[:prefix])
      
      #items = projects.group_by{ |p| Set.new(contributors_for(p)) }.collect do |title,plist| 
      items = projects.collect do |p| 
        meta = {
          :title => p[:title],
          :contributors => contributors_for(p),
          :url => p[:url],
          :tag => tag_for(p[:title])
        }
        sha1 = Digest::SHA1.hexdigest(meta[:contributors].join(','))
        identifier = "/f13/#{sha1}"

        warn "title: #{p[:title]} no descriptin" unless p[:description]
        p[:description] ? Nanoc::Item.new(p[:description],
                        meta,
                        identifier
                        ) : nil
      end.compact
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
