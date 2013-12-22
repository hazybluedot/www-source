usage 'list_entries'
aliases :list_entries
description 'List all syndicated items, grouped by author'

class ListEntries < Nanoc::CLI::CommandRunner
  def run
    self.require_site
    
    if arguments.any?
      arguments.each do |arg|
        puts arg + " " + syndicated.select{ |s| s[:author_uri] == arg}.count.to_s
      end
    else
      syndicated.group_by{ |s| s[:author_uri]}.each do |group|
        puts group.first + " " + group[1].count.to_s
        #group[1].each do |entry|
        #  puts "\t" + entry.identifier
        #end
      end
    end
  end

  def syndicated
    @site.items.select { |item| item[:kind] ==  'syndicate' }
  end
end

runner ListEntries
