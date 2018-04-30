require_relative '../command'
require_relative 'horizontal_validator'

module Commands
  class Horizontal < Command
    include HorizontalValidator

    def perform
      if valid?
        parse_params
        draw
      elsif !valid_params?
        raise 'Invalid Horizontal command coordinates'
      else
        raise 'Invalid Horizontal command format'
      end
    end

    private

    def draw
      @layout[@y][@x1..@x2] = @colour * (@x2 - @x1 + 1)
      @layout
    end

    def parse_params
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      if coordinates[1] > coordinates[0]
        @x1 = coordinates[0]
        @x2 = coordinates[1]
      else
        @x1 = coordinates[1]
        @x2 = coordinates[0]
      end
      @x1 -= 1
      @x2 -= 1
      @y ||= coordinates[2] - 1
      @colour ||= @exec_line[-1]
    end
  end
end
