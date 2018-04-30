require_relative 'command'

module Commands
  class Pixel < Command
    def perform
      if valid?
        parse_params
        draw
      elsif !valid_params?
        raise 'Invalid Pixel command coordinates - pixel is out of image'
      else
        raise 'Invalid Pixel command format'
      end
    end

    private

    def draw
      @layout[@y][@x] = @colour
      @layout
    end

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

    def parse_params
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      @x ||= coordinates[0] - 1
      @y ||= coordinates[1] - 1
      @colour ||= @exec_line[-1]
    end
  end
end
