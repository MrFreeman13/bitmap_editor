module Commands
  module CreateValidator
    def valid_format?
      @exec_line != nil && !!@exec_line.match(/^I [1-9]\d* [1-9]\d*$/)
    end

    def valid_params?
      parse_coordinates
      @n.between?(Command::COLUMN_NUMBER_MIN, Command::COLUMN_NUMBER_MAX) &&
        @m.between?(Command::ROW_NUMBER_MIN, Command::ROW_NUMBER_MAX)
    end
  end
end
