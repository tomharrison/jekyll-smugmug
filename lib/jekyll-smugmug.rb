require 'jekyll'
require 'liquid'
require 'jekyll-smugmug/smugmug'
require 'jekyll-smugmug/smugmug_img'
require 'jekyll-smugmug/smugmug_url'

Liquid::Template.register_tag('smugmug', Jekyll::SmugmugImgTag)
Liquid::Template.register_tag('smugmug_url', Jekyll::SmugmugUrlTag)
