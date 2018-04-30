require_relative '../command'
require_relative 'show_validator'

module Commands
  class Show < Command
    include ShowValidator

    def perform
      if valid?
        show_content
      else
        raise CommandError.new('Invalid Show command format', @exec_line)
      end
    end

    private

    def show_content
      if @layout.any?
        @layout.each do |row|
          puts row
        end
      else
        puts 'There is no image'
      end
      @layout
    end
  end
end
