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
