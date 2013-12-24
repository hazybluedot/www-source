include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering


require 'uri'
require 'summarize'

module PostHelper
  def rfc_time(time)
    DateTime.parse(attribute_to_time(time).strftime('%B %-d, %Y %H:%M %z')).rfc3339
  end
  
  def pretty_time(time)
    attribute_to_time(time).strftime('%B %-d, %Y')
  end

  def pub_prettydate(post)
    pretty_time(post[:created_at])
  end

  def mod_prettydate(post)
    pretty_time(post[:mtime])
  end

  def pub_datetime(post)
    rfc_time(post[:created_at])
  end

  def mod_datetime(post)
    rfc_time(post[:mtime])
  end

  def time_tag(time)
    "<time pubtime datetime=\"#{rfc_time(time)}\">#{pretty_time(time)}</time>"
  end

  def get_post_topics(post)
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
    }
    post.raw_content.encode(Encoding.find('ASCII'), encoding_options).summarize(:topics => true)
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
        "<footer><div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div></footer>"
    end
    return content
  end

  def image_tag(image)
    content = "<img src='#{image}' />"
  end

  def image_link(image, href)
    "<a href='#{href}'><img src='#{image}' /></a>"
  end

  def grouped_articles
    sorted_articles.group_by do |post|
      [ attribute_to_time(post[:created_at]).strftime('%Y'), attribute_to_time(post[:created_at]).strftime('%B') ]
    end
  end

  def tweet_this_url(post)
    post_url = URI::encode(url_for(post))
    "https://twitter.com/intent/tweet?original_referer=#{post_url}&text=#{post[:title]}&url=#{post_url}&via=hazybluedot"
  end
end


class YouTubeFilter < Nanoc::Filter
  identifier :youtube
  type :text
  
  def run(content, params={})
#    content.gsub(/[a-z]+/, 'nanoc rules')
    content.each_line.map do |line|
      url = line.gsub('\_','_')
      youtube_id = nil
      if url[/^\s*(?:https?:\/\/)?(?:www\.)?(?:youtube\.com(?:\/(?:watch(?:\?(?:\w+=\w+&)+|\?)v=?))|youtu\.be\/)(.+)/]
        youtube_id = $1
      end
      
      if youtube_id
        line  = %Q{<p><iframe title="YouTube video player" width="584" height="329" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe></p>}
      else
        line
      end
    end.join("")
  end
end

include PostHelper
