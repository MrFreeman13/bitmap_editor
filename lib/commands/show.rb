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
      @layout.each do |row|
        puts row
      end
    end
  end
end
