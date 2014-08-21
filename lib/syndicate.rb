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

    def syndicated_list(title, ident, items, item_layout:'article_slug', identifier:nil)
      dest_id = identifier ? identifier : ident
      Nanoc::Item.new("", {
                      :title => title, 
                      :kind => 'article_list', 
                      :items => items,
                      :item_layout => item_layout },
                      dest_id
                      )
    end

    def recent_posts(title, identifier, range=(0..-1))
      syndicated_list(title, identifier, sorted_syndicates[range], item_layout:'article_slug')
    end

    def author_of(post)
      name = post[:author_name] ? post[:author_name] : "Anonymous"
      post[:author_uri] ? link_to(name, post[:author_uri]) : name
    end  

    def get_post_summary(post)
      encoding_options = {
        :invalid           => :replace,  # Replace invalid byte sequences
        :undef             => :replace,  # Replace anything not defined in ASCII
        :replace           => '',        # Use a blank for those replacements
        :universal_newline => true       # Always break lines with \n
      }
      raw_content = get_post_raw_start(post)
      Kramdown::Document.new(raw_content).to_html.encode(Encoding.find('ASCII'), encoding_options).summarize(:ratio => 25)
    end
    
    def get_post_start(post)
      content = post.compiled_content
      if content =~ /\s<!-- more -->\s/
        content = content.partition('<!-- more -->').first +
          "<footer><div class='read-more'><a href='#{post[:entry_url]}'>Continue reading &rsaquo;</a></div></footer>"
      end
      content
    end
  end
end

include Nanoc::Helpers::Syndicate
