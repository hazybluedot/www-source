# encoding: utf-8

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
