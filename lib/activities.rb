include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering
include Nanoc::Extra::FilesystemTools

module ActivityHelper
  def has_tests(item)
    return ( item[:tests] && item[:tests].any?  )
  end
  
  def has_user_repo(item)
    return ( item[:repos] && item[:repos].select{ |r| r[:user]}.any? )
  end

  def user_repo(item)
    # $stderr.puts "Adding user repo for " + item.identifier
    item[:repos].select{ |r| r[:user]}.first[:user]
  end

  def features(f)
    if f[:type] == 'bonair'
      collect_features(f[:feature], f[:tags] ? f[:tags] : nil)
    end
  end

  # @return [Array] An array of feature repos for this item
  def feature_repos(item)
    item[:tests].select { |t| t[:feature] }
  end

  def collect_features(repo, tags)
    features = []
    feature_base = File.expand_path('~/ece2524/')
    feature_path = File.join(feature_base, repo)
    # $stderr.puts "Adding features in " + feature_path
    if Dir.exists?(feature_path)
      features.concat(all_files_in(feature_path).select{ |file|  File.extname(file) == '.feature'}.map do |feature|
                        File.open(feature, 'r') do |io|
                          io.read()
                        end
                      end)
      if tags
        # $stderr.puts "Checking for tags: " + tags.map { |tag| Regexp.new('@' + tag) }.inspect
        tags = tags.map { |tag| Regexp.new('@' + tag) }
        features = features.select{ |feature| tags.map{ |tag| feature =~ tag }.any? }
      end
    else
      $stderr.puts feature_path + ": feature path does not exist"
    end
    features
  end

  # @return [Array] An array of activites, i.e. items in the /activites/ subdirectory
  def activities
    @items.select { |i| i.identifier =~ /^\/activities\/\w+/ }
  end

  # @return [Array] An array of activites with for_date
  def activities_for(for_date)
    activities.select { |i| i[:for_date] && i[:for_date] == for_date }
  end
end

include ActivityHelper
