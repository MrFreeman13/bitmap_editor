require_relative 'command'

module Commands
  class Create < Command
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

    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^I [1-9]\d* [1-9]\d*$/)
    end

    def valid_params?
      parse_coordinates
      @n.between?(COLUMN_NUMBER_MIN, COLUMN_NUMBER_MAX) && @m.between?(ROW_NUMBER_MIN, ROW_NUMBER_MAX)
    end

    def parse_coordinates
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      @n ||= coordinates[0]
      @m ||= coordinates[1]
    end
  end
end
