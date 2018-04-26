require_relative 'command'

module Commands
  class Show < Command
    def valid?
      @exec_line != nil && !!@exec_line.match(/^S$/)
    end
  end
end
