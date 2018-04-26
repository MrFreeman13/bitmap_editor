require_relative 'command'

module Commands
  class Show < Command
    def perform
      if valid?
        show_content
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
        puts 'The image is empty'
      end
    end
  end
end
