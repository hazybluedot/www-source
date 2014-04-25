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

  def requirement(activity, type)
    if ( activity[:requires]  && Hash === activity[:requires] && activity[:requires].has_key?(type) )
      bg_topics = activity[:requires][type]
      bg_topics = String === bg_topics ? [ bg_topics ] : bg_topics
      @items.select { |i| ( list_for(i, :provides, type) & bg_topics ).any? }
    end
  end
  
  def background_items(activity)
    activity = @items.select { |i| i.identifier == activity }.first if activity.is_a?(String)
    #$stderr.puts "#{activity[:requires]}"
    items = []
    items << requirement(activity, :background)
    items << requirement(activity, :practice)
    items << requirement(activity, :experience)
    items.flatten.compact
  end

  def link_or_content(item)
    if item[:inline]
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
  
  def first_string string_or_array
    return string_or_array.first if string_or_array.respond_to? :first
    string_or_array
  end

  def due_or_open(item)
    item.collect { |k,v| DateTime.parse(first_string(v)) }.first
  end

  def explode(items)
    #$stderr.puts "Exploding: #{items}"
    items.collect { |k,v| v.collect { |k1,v1| Hash[k, { k1 => v1 }]} }.flatten.reduce Hash.new, :merge
  end

  def transform_hash(original, options={}, &block)
    options[:safe_descent] ||= {}
    new_hash = {}
    options[:safe_descent][original.object_id] = new_hash
    original.inject(new_hash) { |result, (key,value)|
      if (options[:deep] && Hash === value)
        value = options[:safe_descent].fetch( value.object_id ) {
          transform_hash(value, options, &block)
        }
      end
      block.call(result,key,value)
      result
    }
  end

  def item_select(stuffs, sym)
    stuffs.select { |(k,v)| v.has_key? sym }.collect { |(k,v)| k }
  end

  def activity_by_date(items) 
    dates = explode(items).group_by { |k,v| due_or_open(v) }
    dates.sort_by { |date,_| date }.reverse
  end
  
  def items_by_id(id)
    @items.select { |i| i.identifier == id.to_s }
  end
  
  def item_links(item_ids)
    links = item_ids.collect do |id| 
      it = items_by_id(id).first
      link = nil
      link = { it[:title] => it } if it
      link
    end.compact
    #$stderr.puts "links: #{links}"
    links.inject Hash.new, :merge
  end

  def merge_backgrounds(k,v)
    { k => v.merge({ :backgrounds => background_items( k.to_s ) }) }
  end

  def insert_or_merge(h1, id, h2)
    id = id.to_sym
    merged = h1
    if h1.has_key? id
      #$stderr.puts "merging #{h1[id]} with #{h2}"
      merged[id].merge(h2) 
    end
    #$stderr.puts "setting merged[#{id}] = #{h2}" unless h1.has_key? id
    merged[id] = h2 unless h1.has_key? id
    merged
  end

  def value_merge(h1, h2) 
    h2.collect { |k,v| insert_or_merge(h1, k, v) }.reduce Hash.new, :merge
  end
    
  def set_duedate(item_ids, date)
    item_ids.collect { |id| { id => { :due => date } } }
  end

  def insert_background_dates(schedule)
    backgrounds = schedule.select { |k,v| (v.has_key? :open) || (v.has_key? :inclass) }
    bg_schedule_items = backgrounds.collect { |k,v| set_duedate(background_items(k.to_s).collect { |i| i.identifier}, v[:open] || v[:inclass] ) }.flatten
    my_hash = bg_schedule_items.reduce Hash.new, :merge
    my_hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

  def activity_schedule(identifier, options={})
    activity_list = @items.select { |i| i.identifier == options[:activity_list] }
    schedule = [activity_list[0][:schedule]].reduce Hash.new, :merge
    bg_items = insert_background_dates(schedule)
    #$stderr.puts "schedule: #{schedule}"
    #$stderr.puts "bg_items: #{bg_items}"
    schedule = value_merge(schedule, bg_items)
    #$stderr.puts "Merged Schedule Debug"
    #schedule.each { |k,v| $stderr.puts "#{k} => #{v}" }
    #$stderr.puts "merged schedule: #{schedule}"
    Nanoc::Item.new("",
                    { :title => "Activity Schedule",
                      :schedule => schedule
                      },
                    identifier
                    )
  end
end

include ActivityHelper
