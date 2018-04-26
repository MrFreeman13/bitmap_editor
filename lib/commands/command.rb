module Commands
  class Command
    COLUMN_NUMBER_MIN = ROW_NUMBER_MIN = 1
    COLUMN_NUMBER_MAX = ROW_NUMBER_MAX = 250
    START_X = START_Y = 1
    DEFAULT_COLOUR = 'O'

    def initialize(line, layout = [])
      @exec_line = line
      @layout = layout
    end

    def valid?
      valid_format? && valid_params?
    end
  end
end
