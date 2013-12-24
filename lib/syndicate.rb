# encoding: utf-8

module Nanoc::Helpers
  module Syndicate

    # Returns an unsorted list of entries from across all feeds, 
    # i.e. items where the `kind`  attribute is set to `"syndicate"`.
    #
    # @return [Array] An array containing all syndicated entries
    def syndicates
      @items.select { |item| item[:kind] == 'syndicate' }
    end

    # Returns a sorted list of syndicated articles, i.e. items where the `kind`
    # attribute is set to `"syndicate"`. Articles are sorted by descending
    # creation date, so newer articles appear before older articles.
    #
    # @return [Array] A sorted array containing all articles
    def sorted_syndicates
      syndicates.sort_by do |a|
        attribute_to_time(a[:created_at])
      end.reverse
    end

    def recent_posts(range, title, identifier)
      Nanoc::Item.new("", {
                        :title => title, 
                        :kind => 'article_list', 
                        :items => sorted_syndicates[range] },
                        identifier 
                      )
    end

    def author_of(post)
      name = post[:author_name] ? post[:author_name] : "Anonymous"
      post[:author_uri] ? link_to(name, post[:author_uri]) : name
    end
    
  end
end

include Nanoc::Helpers::Syndicate
