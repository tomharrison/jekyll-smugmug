require 'smugimg'

module Jekyll
  class SmugmugTag < Liquid::Tag
    DimensionsFormat = /([0-9]+x[0-9]+|Ti|Th|S|M|L|XL|X2|X3|O)/

    def initialize(tag_name, markup, tokens)
      super

      @attrib = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attrib[key] = value
      end
    end

    protected

    def resized_url(guid, size)
      SmugImg::Image.new(guid).at_size(size)
    end
  end
end
