include Nanoc::Extra::FilesystemTools

require 'cucumber'

module Nanoc::DataSources

  class CukeFeatures < Nanoc::DataSource
    identifier cuke_features
    
    def items
      load_features(config[:src_root])
    end

    private
    
    def features(feature_content) 
      feature_content.select { |line| /Feature:/ =~ line }.collect { |line| line.partition(':')[2] }
    end

    def tags(feature_content)
      feature_content.select { |line|
    end

    def load_features(src_root)
      all_files_in(feature_path).select{ |file|  File.extname(file) == '.feature'}.collect do |feature|
        content = File.read(feature, 'r')
        identifier = feature_path.gsub(src_root, '')
        meta = {
          :title => features(content).first,
          :tags => tags(content)
        }
        Nanoc::Item.new(content, identifier, meta)
      end
    end

  end

end

