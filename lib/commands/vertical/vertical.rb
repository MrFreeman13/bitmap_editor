require_relative '../command'
require_relative 'vertical_validator'

module Commands
  class Vertical < Command
    include VerticalValidator

    def perform
      if valid?
        parse_params
        draw
      elsif !valid_params?
        raise CommandError.new('Invalid Vertical command coordinates', @exec_line)
      else
        raise CommandError.new('Invalid Vertical command format', @exec_line)
      end
    end

    private

    def draw
      (@y1..@y2).each do |row|
        @layout[row][@x] = @colour
      end
      @layout
    end

    def parse_params
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      @x ||= coordinates[0] - 1
      if coordinates[2] > coordinates[1]
        @y1 = coordinates[1]
        @y2 = coordinates[2]
      else
        @y1 = coordinates[2]
        @y2 = coordinates[1]
      end
      @y1 -= 1
      @y2 -= 1
      @colour ||= @exec_line[-1]
    end
  end
end
