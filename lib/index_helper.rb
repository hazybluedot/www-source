include Nanoc::Helpers::Rendering

module IndexHelper
  
  # taken from https://github.com/cucumber/aruba/blob/master/lib/aruba/api.rb
  # TODO: probably doesn't belong in this helper
  def regexp(string_or_regexp)
    Regexp === string_or_regexp ? string_or_regexp : Regexp.compile(Regexp.escape(string_or_regexp))
  end
  
  def title_string(string_or_regexp)
    Regexp === string_or_regexp ? string_or_regexp.to_s : string_or_regexp 
  end

  def index_item_for(path, title=title_string(path))
    $stderr.puts "Generating index page for " + title
    content = render('index_page', :items => @items.select { |i| i.identifier =~ regexp(path) })    
    Nanoc::Item.new(content, {:title => title}, "/references/" )
  end
end

include IndexHelper
