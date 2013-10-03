include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering
include Nanoc::Extra::FilesystemTools

module ActivityHelper
  def has_tests(item)
    return ( item[:test_type] != nil )
  end
  
  def features(item)
    case item[:test_type]
    when 'bonair'
      repo = item[:feature]
      features = collect_features(repo)
    else
      puts "test type " + item[:test_type] + " not implemented"
    end
  end

  def feature_repo(item)
    repo = item[:feature]
  end

  def collect_features(repo)
    features = []
    feature_base = File.expand_path('~/ece2524/')
    feature_path = File.join(feature_base, repo)
    $stderr.puts "Adding features in " + feature_path
    if Dir.exists?(feature_path)
      features.concat(all_files_in(feature_path).select{ |file| File.extname(file) == '.feature'}.map do |feature|
                        File.open(feature, 'r') do |io|
                          io.read()
                        end
                      end)
    end
    features
  end
end

include ActivityHelper
