# encoding: utf-8

module Nanoc::DataSources
  class Taxonomy < Nanoc::DataSource
    identifier :taxonomy

    def items
      load_items('taxonomy/tools.yaml')
    end

    private

    def load_items(path)
      terms = YAML.load_file(path)
      identifier = path.split('/').last.split('.').first
      terms.collect { |t,v| Nanoc::Item.new("", v, identifier + '/' + t) }
    end
  end
end
