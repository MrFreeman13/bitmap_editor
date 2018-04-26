module Commands
  class Show
    COLUMN_NUMBER_MIN = ROW_NUMBER_MIN = 1
    COLUMN_NUMBER_MAX = ROW_NUMBER_MAX = 250
    START_X = START_Y = 1
    DEFAULT_COLOUR = 'O'

    def initialize(line, layout = [])
      @exec_line = line
      @layout = layout
    end

    def valid?
      valid_format?
    end

    private

    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^S$/)
    end
  end
end
