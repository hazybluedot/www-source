include Nanoc::Extra::FilesystemTools

module Nanoc::DataSources
  class Snippets < Nanoc::DataSource
    identifier :snippets

    def items
      prefix = config[:prefix] || 'snippets'
      self.all_files_in(prefix).map do |filename|
        meta = {
          :mime_type => `file -ib #{filename}`.gsub(/\n/,""),
        }
        identifier = filename[(prefix.length+1)..-1] + '/'
        Nanoc::Item.new(File.open(filename, 'r') { |io| io.read() },
                        meta,
                        identifier
                        )
      end
    end
    
    protected
    
    def all_files_in(dir_name)
      Nanoc::Extra::FilesystemTools.all_files_in(dir_name)
    end
  end
end

