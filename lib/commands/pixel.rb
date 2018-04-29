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
      @layout[@y - 1][@x - 1] = @colour
      @layout
    end

    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^L \d+ \d+ [A-Z]$/)
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
      @x ||= coordinates[0]
      @y ||= coordinates[1]
      @colour ||= @exec_line[-1]
    end
  end
end
