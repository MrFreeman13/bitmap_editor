module Commands
  module ClearValidator
    def valid?
      @exec_line != nil && !!@exec_line.match(/^C$/)
    end
  end
end
