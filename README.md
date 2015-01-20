# Smugmug Jekyll Plugin
By [Tom Harrison](http://www.thetomharrison.com)

![Travis CI build status](https://api.travis-ci.org/tomharrison/jekyll-smugmug.png)

Easily render SmugMug photos in your Jekyll-powered site.

This is not official SmugMug software, and is not affiliated with nor endorsed by SmugMug, Inc.

## Getting Started

This plugin creates a `smugmug` Liquid tag which accepts dimensions and a photo GUID, and outputs either a URL to that photo at the given size, or the complete image tag.

    {% smugmug dimensions: 800x800 guid: page.photo.guid alt: page.photo.alt_text %} 
    {% smugmug_url dimensions: 800x800 guid: page.photo.guid alt: page.photo.alt_text %}

## Sample Usage

Install "jekyll-smugmug" via Ruby gems:

    $ gem install jekyll-smugmug

Or add it to your site's Gemfile:

    gem 'jekyll-smugmug'

Create a "_plugins" folder (if one doesn't already exist) and add a filed named "jekyll-smugmug.rb" with these contents:

    require 'jekyll-smugmug'

If you already do this for other plugins with something like an "ext.rb" plugin script, you can add the require to that file instead.

Now you can use these custom tags in your templates:

    {% smugmug dimensions: XL guid: post.my_guid alt: 'Hello, World!' %}
    {% smugmug_url dimensions: 500x500 guid: page.my_guid %}

The output:

    <img src="http://example.com/some/image-XL.jpg" alt="Hello, World!" class="smphoto" />
    http://example.com/some/image-500x500.jpg

## Tag Attributes

### Common Attributes

**dimensions** The size of the JPEG you would like to serve. You can use pre-defined Smugmug sizes like S, M, L, XL, etc... or pass custom sizes in the format WIDTHxHEIGHT, like 500x500.

**guid** The unique URL that identifies an image in your Smugmug account. This can be a hard-coded value, or a variable from the current page/post's front matter.

These GUIDs are commonly found in SmugMug RSS feeds. [Here's mine](http://galleries.thetomharrison.com/hack/feed.mg?Type=gallery&Data=13758467_8tbSRw&format=rss200&ImageCount=5) with my latest 5 photos. I use [Ruby script](https://github.com/tomharrison/thetomharrison.com/blob/master/newphoto) to pull down images, save their meta data to YAML front matter in my photo blog posts, then build my templates with these Liquid tags.

### Smugmug Tag Attributes

**alt** Value for the img tag's "alt" attribute.

## License

[MIT](LICENSE.txt)
