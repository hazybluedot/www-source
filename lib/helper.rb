include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering


require 'uri'
require 'summarize'

module PostHelper
  def attribute_to_datetime(time)
    time = DateTime.parse(time) if time.is_a?(String)
    time
  end

  def rfc_time(time)
    DateTime.parse(attribute_to_datetime(time).strftime('%B %-d, %Y %H:%M %z')).rfc3339
  end
  
  def pretty_time(time, format='%B %-d, %Y')
    attribute_to_datetime(time).strftime(format)
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

  def time_tag(time, format='%B %-d, %Y')
    "<time pubtime datetime=\"#{rfc_time(time)}\">#{pretty_time(time, format)}</time>"
  end

  def topics_for(post)
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
    }
    post.raw_content.encode(Encoding.find('ASCII'), encoding_options).summarize(:topics => true)
  end

  def image_tag(image)
    content = "<img src='#{image}' />"
  end

  def image_link(image, href)
    "<a href='#{href}'><img src='#{image}' /></a>"
  end
end

include PostHelper
