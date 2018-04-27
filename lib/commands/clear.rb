require_relative 'command'

module Commands
  class Clear < Command
    def perform
      if valid?
        clear_table
      else
        raise 'Invalid Clear command format'
      end
    end

    def valid?
      @exec_line != nil && !!@exec_line.match(/^C$/)
    end

    private

    def clear_table
      if @layout.any?
        @layout.map! { |row| DEFAULT_COLOUR * row.size }
      else
        raise "Can't clear the table for no image"
      end
    end
  end
end
