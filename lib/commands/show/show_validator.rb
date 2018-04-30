module Commands
  module ShowValidator
    def valid?
      @exec_line != nil && !!@exec_line.match(/^S$/)
    end
  end
end
