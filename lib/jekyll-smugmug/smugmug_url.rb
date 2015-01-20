module Jekyll
  class SmugmugUrlTag < SmugmugTag
    SmugmugSyntax = "smugmug_url dimensions: [width]x[height] guid: [url]"

    def initialize(tag_name, markup, tokens)
      super

      unless @attrib["dimensions"] and @attrib["dimensions"] =~ DimensionsFormat
        raise SyntaxError.new("Syntax error in 'smugmug_url' - Valid syntax: #{SmugmugSyntax}")
      end
    end

    def render(context)
      guid = context.has_key?(@attrib['guid']) ? context[@attrib['guid']] : @attrib['guid']
      resized_url(guid, @attrib["dimensions"])
    end
  end
end
