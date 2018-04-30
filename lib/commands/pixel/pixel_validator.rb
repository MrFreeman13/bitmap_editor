module Commands
  module PixelValidator
    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^L [1-9]\d* [1-9]\d* [A-Z]$/)
    end

    def valid_params?
      parse_params
      inside_image?
    end

    def inside_image?
      @y <= @layout.size && @x <= @layout.first.size
    end
  end
end
