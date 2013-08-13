# The MIT License (MIT)
#
# Copyright (c) 2013 Tom Harrison
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Jekyll
  class SmugmugTag < Liquid::Tag
    DimensionsFormat = /([0-9]+x[0-9]+|Th|S|M|L|XL|XXL)/
    GuidFormatA = /^(.+?)\/Th\/(.+?)-Th\.([A-Za-z]+)$/
    GuidFormatB = /^(.+?)-Th\.([a-z]+)$/

    def initialize(tag_name, markup, tokens)
      super

      @attrib = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attrib[key] = value
      end
    end

    protected

    def resized_url(guid, size)
      if guid =~ GuidFormatA
        return "#{$1}/#{size}/#{$2}-#{size}.#{$3}"
      elsif guid =~ GuidFormatB
        return "#{$1}-#{size}-#{$2}"
      else
        return guid
      end
    end
  end

  class SmugmugImgTag < SmugmugTag
    SmugmugSyntax = "smugmug dimensions: [width]x[height] guid: [url]"
    DefaultAltText = "The photograph"

    def initialize(tag_name, markup, tokens)
      super

      unless @attrib["dimensions"] and @attrib["dimensions"] =~ DimensionsFormat
        raise SyntaxError.new("Syntax error in 'smugmug' - Valid syntax: #{SmugmugSyntax}") 
      end

      unless @attrib["alt"]
        @attrib["alt"] = DefaultAltText
      end
    end

    def render(context)
      url = resized_url(context[@attrib["guid"]], @attrib["dimensions"])
      alt = context[@attrib["alt"]]
      return %Q(<img src="#{url}" alt="#{alt}" class="smphoto" />)
    end
  end

  class SmugmugUrlTag < SmugmugTag
    SmugmugSyntax = "smugmug_url dimensions: [width]x[height] guid: [url]"

    def initialize(tag_name, markup, tokens)
      super

      unless @attrib["dimensions"] and @attrib["dimensions"] =~ DimensionsFormat
        raise SyntaxError.new("Syntax error in 'smugmug_url' - Valid syntax: #{SmugmugSyntax}")
      end
    end

    def render(context)
      resized_url(context[@attrib["guid"]], @attrib["dimensions"])
    end
  end

  Liquid::Template.register_tag('smugmug', Jekyll::SmugmugImgTag)
  Liquid::Template.register_tag('smugmug_url', Jekyll::SmugmugUrlTag)
end
