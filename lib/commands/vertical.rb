require_relative 'command'

module Commands
  class Vertical < Command
    private

    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^V [1-9]\d* [1-9]\d* [1-9]\d* [A-Z]$/)
    end

    def valid_params?
      parse_params
      inside_image?
    end

    def inside_image?
      @y1 <= @layout.size && @y2 <= @layout.size && @x <= @layout.first.size
    end

    def parse_params
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      @x ||= coordinates[0]
      @y1 ||= coordinates[1]
      @y2 ||= coordinates[2]
      @colour ||= @exec_line[-1]
    end
  end
end
