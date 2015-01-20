require 'bundler/setup'

Bundler.setup

require 'jekyll-smugmug'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
end
