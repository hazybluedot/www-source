require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'multi_json'
require 'cgi'

include Nanoc::Extra::FilesystemTools

module Gherkin
  module Formatter
    class JSONFormatter
      def features
        @feature_hashes
      end
    end
  end
end

module Nanoc::DataSources

  class CukeFeatures < Nanoc::DataSource
    identifier :cuke_features
    
    def items
      load_features(config[:feature_path])
    end

    private
    
    def features(feature_content) 
      feature_content.select { |line| /Feature:/ =~ line }.collect { |line| line.partition(':')[2] }
    end

    def tags(feature_content)
      feature_content.select { |line| /@\w+/ =~ line }.collect { |line| line.scan(/(:?(@[-a-z0-9_]+)\s*)/).flatten.collect { |s| s.strip }.uniq }.flatten
    end

    def load_features(feature_path)
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)

      feature_path = File.join(Dir.pwd,feature_path)
      feature_files = all_files_in(feature_path).select{ |file|  File.extname(file) == '.feature'}
      feature_files.each do |path|
        parser.parse(IO.read(path), path, 0)
      end

      #formatter.features.each { |f| $stderr.puts "feature: #{f["name"]}" }
      #formatter.features.select { |f| f["keyword"] == "Feature" }.each { |f| "$stderr.puts #{f["name"]} " }
      
      all_files_in(feature_path).select{ |file|  File.extname(file) == '.feature'}.collect do |feature|
        content = File.open(feature, 'r').readlines
        identifier = File.join(config[:items_root],feature.partition(feature_path)[2].gsub('.feature','')) + "/"
        meta = {
          :title => features(content).first,
          :tags => tags(content)
        }
        Nanoc::Item.new("<pre><code>#!gherkin\n#{CGI.escapeHTML(content.join(''))}</code></pre>", meta, identifier)
      end
    end

  end

end

