require_relative '../../lib/commands/show/show'

describe Commands::Show do
  describe '#valid' do
    it 'should validate valid command line' do
      command_line = described_class.new('S')
      expect(command_line.valid?).to be true
    end

    it 'should invalidate nil command line' do
      command_line = described_class.new(nil)
      expect(command_line.valid?).to be false
    end

    it 'should invalidate command line with extra character at the end' do
      command_line = described_class.new('S ^')
      expect(command_line.valid?).to be false
    end
  end

  describe '#perform' do
    it 'should show the content of the current image' do
      image = %w(OOOO CCCC OKKO)
      expect { described_class.new('S', image).perform }.to output("OOOO\nCCCC\nOKKO\n").to_stdout
    end

    it 'should show the message if there is no image' do
      expect { described_class.new('S').perform }.to output("There is no image\n").to_stdout
    end

    it 'should raise an exception for fail validation while performing' do
      expect { described_class.new('S ').perform }.
        to raise_error(Commands::CommandError, "Invalid Show command format in line: 'S '")
    end
  end
end
