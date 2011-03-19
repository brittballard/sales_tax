Dir.foreach(File.dirname(__FILE__) + "/../app/") do |f| 
  require File.dirname(__FILE__) + "/../app/" + f if f =~ /\w+\.rb/
end

RSpec.configure do |config|
  config.mock_with :rspec
end