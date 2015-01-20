Gem::Specification.new do |s|
  s.name = 'jekyll-smugmug'
  s.version = '0.0.1'
  s.date = '2015-01-19'
  s.summary = 'Liquid tags for displaying SmugMug photos on a Jekyll site'
  s.description = 'jekyll-smugmug is a plugin which creates custom Liquid tags so that you can easily generate URLs and IMG tags to SmugMug photos in your Jekyll-powered site.'
  s.authors = ['Tom Harrison']
  s.email = 'tomharrison@gmail.com'
  s.files = [
    'lib/jekyll-smugmug.rb',
    'lib/jekyll-smugmug/smugmug.rb',
    'lib/jekyll-smugmug/smugmug_img.rb',
    'lib/jekyll-smugmug/smugmug_url.rb'
  ]
  s.homepage = 'https://github.com/tomharrison/jekyll-smugmug'
  s.license = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'rake', '~> 10.4'
end
