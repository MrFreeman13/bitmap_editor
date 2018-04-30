require_relative '../command'
require_relative 'clear_validator'

module Commands
  class Clear < Command
    include ClearValidator

    def perform
      if valid?
        clear_table
      else
        raise 'Invalid Clear command format'
      end
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
