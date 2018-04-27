require_relative 'commands/create'
require_relative 'commands/show'

class BitmapEditor
  attr_reader :layout

  def initialize
    @layout = []
  end

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line[0]
      when 'S'
        Commands::Show.new(line, layout).perform
      when 'I'
        @layout = Commands::Create.new(line, layout).perform
      else
        puts 'unrecognised command :('
      end
    end
  end
end
