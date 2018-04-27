require_relative 'command'

module Commands
  class Pixel < Command

    private
    
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
