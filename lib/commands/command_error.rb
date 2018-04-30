module Commands
  class CommandError < StandardError
    attr_reader :exec_line

    def initialize(msg='Command Error', line)
      @exec_line = line
      super("#{msg} in line: '#{exec_line}'")
    end
  end
end
