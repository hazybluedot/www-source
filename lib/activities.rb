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
    features = @items.select { |item| item.identifier =~ /#{repo}/ }
    if tags
      # $stderr.puts "Checking for tags: " + tags.map { |tag| Regexp.new('@' + tag) }.inspect
      tags = tags.collect { |tag| '@' + tag }
      features = features.select{ |feature| (feature[:tags] & tags).any? }
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

  def list_for(item, key1, key2)
    provided = []
    if ( item[key1] && Hash === item[key1] && item[key1].has_key?(key2) )
      backgrounds = item[key1][key2]
      provided = String === backgrounds ? [ backgrounds ] : backgrounds
    end
    provided
  end

  def background_items(activity)
    #$stderr.puts "#{activity[:requires]}"
    items = []
    if ( activity[:requires]  && Hash === activity[:requires] && activity[:requires].has_key?(:background) )
      bg_topics = activity[:requires][:background]
      bg_topics = String === bg_topics ? [ bg_topics ] : bg_topics
      items = @items.select { |i| ( list_for(i, :provides, :background) & bg_topics ).any? }
    end
    items
  end

  def link_or_content(item)
    if item[:include]
      item.compiled_content
    else
      link_to(item[:title], item)
    end
  end

  def items_that_use(item)
    items = []
    topics_provided = list_for item, :provides, :background
    items = @items.select { |i| ( list_for(i, :requires, :background) & topics_provided ).any? }
    items
  end
end

include ActivityHelper
