module Commands
  module VerticalValidator
    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^V [1-9]\d* [1-9]\d* [1-9]\d* [A-Z]$/)
    end

    def valid_params?
      parse_params
      inside_image? && (@y2 - @y1) != 0
    end

    def inside_image?
      @y1 <= @layout.size && @y2 <= @layout.size && @x <= @layout.first.size
    end
  end
end
