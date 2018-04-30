require_relative 'commands/create'
require_relative 'commands/show'
require_relative 'commands/clear'
require_relative 'commands/pixel'
require_relative 'commands/vertical'
require_relative 'commands/horizontal'

class BitmapEditor
  COMMANDS = {
    'S' => 'Show',
    'I' => 'Create',
    'C' => 'Clear',
    'L' => 'Pixel',
    'V' => 'Vertical',
    'H' => 'Horizontal'
  }.freeze

  attr_reader :layout

  def initialize
    @layout = []
  end

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp

      if COMMANDS[line[0]]
        @layout = Object.const_get("Commands::#{COMMANDS[line[0]]}").new(line, layout).perform
      elsif !line.empty?
        puts 'unrecognised command :('
      end
    end
  end
end
