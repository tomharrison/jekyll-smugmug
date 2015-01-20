module Jekyll
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
      guid = context.has_key?(@attrib['guid']) ? context[@attrib['guid']] : @attrib['guid']
      url = resized_url(guid, @attrib["dimensions"])
      alt = context[@attrib["alt"]]
      return %Q(<img src="#{url}" alt="#{alt}" class="smphoto" />)
    end
  end
end
