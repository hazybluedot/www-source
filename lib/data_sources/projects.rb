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
      return if config.has_key? :active && !config[:active]
      system("git-pull-all CREATOR/project repos/project_proposals/CREATOR", :chdir => File.join(ENV['HOME'], 'ece2524/'))
    end
    
    def items
      project_files = all_files_in('./projects/f13').select { |f| /README/ =~ f }
      #$stderr.puts "project_files: #{project_files}"
      items = project_files.collect do |readme| 
        readme = Pathname.new(readme).cleanpath.to_s
        p = load_project File.readlines(readme) 
        meta = {
          :title => p[:title],
          :contributors => contributors_for(p),
          :url => p[:url],
          :tag => tag_for(p[:title]),
          :mtime => p[:mtime]
        }
        sha1 = Digest::SHA1.hexdigest([meta[:title], meta[:contributors]].flatten.join(','))

        identifier = [ readme.split(File::SEPARATOR)[1], sha1 ].flatten.join('/')
        
        # $stderr.puts "#{p[:title]} contributors: #{p[:contributors]}"

        warn "title: #{p[:title]} no description" unless p[:description]
        p[:description] ? Nanoc::Item.new(
                                          p[:description],
                                          meta,
                                          identifier
                                          ) : nil
      end.compact
      items
    end

    private
   
    def all_files_in(dir_name)
      Nanoc::Extra::FilesystemTools.all_files_in(dir_name)
    end

    def contributors_for(p)
      p[:contributors] ? p[:contributors].collect { |c| c.respond_to?('pid') ? c.pid : c } : []
    end

    def load_project(readme_lines)
      raise InvalidProject("Empty content") if readme_lines[0].nil?
      project = {}
      project[:title] = readme_lines[0] ? readme_lines[0].gsub(/^#*\s*/, '').chomp : nil
      project[:description] = ""
      project[:contributors] = []
      readme_lines[1..-1].each do |line|
        if line =~ /^contributors:/
          project[:expected_contributors] = line.split(':')[1].split(',').count
          contrib_str = line.split(':')[1]
          project[:raw_contributors] = raw_contributors(contrib_str)
          project[:contributors] = raw_contributors(contrib_str)
          next
        end
        
        if line =~ /^url:/
          project[:url] = line.split(':')[1..-1].join(':').strip
          next
        end
        project[:description] << line
      end
      project
    end

    def find_project_readme(prefix='.')
      readme_file = Dir.glob(File.join(prefix, 'README*')).sort{ |s| s.count File::SEPARATOR }.first
    end

  end
end

module Nanoc

  class Site
    attr_accessor :roster
  end

end
