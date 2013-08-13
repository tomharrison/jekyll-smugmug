## Smugmug Jekyll Plugin
By [Tom Harrison](http://www.thetomharrison.com)

This is not official SmugMug software, and is not affiliated with nor endorsed by SmugMug, Inc.

Easily render SmugMug photos in your Jekyll-powered site.

## Getting Started

This plugin creates a `smugmug` Liquid tag which accepts dimensions and a photo GUID, and outputs either a URL to that photo at the given size, or the complete image tag.

    {% smugmug dimensions: 800x800 guid: page.photo.guid alt: page.photo.alt_text %} 
    {% smugmug_url dimensions: 800x800 guid: page.photo.guid alt: page.photo.alt_text %}

## Sample Usage

These GUIDs are commonly found in SmugMug RSS feeds. [Here's mine](http://galleries.thetomharrison.com/hack/feed.mg?Type=gallery&Data=13758467_8tbSRw&format=rss200&ImageCount=5) with my latest 5 photos. I use [Ruby script](https://github.com/tomharrison/thetomharrison.com/blob/master/newphoto) to pull down images, save their meta data to YAML front matter in my photo blog posts, then build my templates with these Liquid tags.

## License

jekyll-smugmug is released under the [MIT License](http://opensource.org/licenses/MIT).
