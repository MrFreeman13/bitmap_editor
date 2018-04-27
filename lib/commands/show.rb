require_relative 'command'

module Commands
  class Show < Command
    def perform
      if valid?
        show_content
      else
        raise 'Invalid Show command format'
      end
    end

    def valid?
      @exec_line != nil && !!@exec_line.match(/^S$/)
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
    end
  end
end
