require_relative '../command'
require_relative 'create_validator'

module Commands
  class Create < Command
    include CreateValidator

    def perform
      if valid?
        parse_coordinates
        draw
      elsif !valid_format?
        raise 'Invalid Create command format'
      else
        raise 'Invalid Create command coordinates: out of allowed range'
      end
    end

    private

    def draw
      @layout = Array.new(@m) { DEFAULT_COLOUR * @n }
    end

    def parse_coordinates
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      @n ||= coordinates[0]
      @m ||= coordinates[1]
    end
  end
end
