module Commands
  class Create
    COLUMN_NUMBER_MIN = ROW_NUMBER_MIN = 1
    COLUMN_NUMBER_MAX = ROW_NUMBER_MAX = 250
    START_X = START_Y = 1
    DEFAULT_COLOUR = 'O'

    def initialize(line)
      @exec_line = line
    end

    def valid?
      @exec_line && valid_format? && valid_params?
    end

    private

    def valid_format?
      !!@exec_line.match(/^I \d+ \d+$/)
    end

    def valid_params?
      parse_coordinates
      @m.between?(COLUMN_NUMBER_MIN, COLUMN_NUMBER_MAX) && @n.between?(ROW_NUMBER_MIN, ROW_NUMBER_MAX)
    end

    def parse_coordinates
      coordinates = @exec_line.scan(/\d+/).map(&:to_i)
      @n = coordinates[0]
      @m = coordinates[1]
    end
  end
end
