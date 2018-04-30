module Commands
  module HorizontalValidator
    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^H [1-9]\d* [1-9]\d* [1-9]\d* [A-Z]$/)
    end

    def valid_params?
      parse_params
      inside_image? && (@x2 - @x1) != 0
    end

    def inside_image?
      @x1 <= @layout.first.size && @x2 <= @layout.first.size && @y <= @layout.size
    end
  end
end
