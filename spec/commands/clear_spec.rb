require_relative '../../lib/commands/clear/clear'

describe Commands::Clear do
  describe '#valid' do
    it 'should validate valid command line' do
      command_line = described_class.new('C')
      expect(command_line.valid?).to be true
    end

    it 'should invalidate nil command line' do
      command_line = described_class.new(nil)
      expect(command_line.valid?).to be false
    end

    it 'should invalidate command line with extra character at the end' do
      command_line = described_class.new('C O')
      expect(command_line.valid?).to be false
    end
  end

  describe '#perform' do
    it 'should clear the table' do
      current_image = %w(AAAAA CCCCC OKKOK)
      updated_image = described_class.new('C', current_image).perform
      expect(updated_image).to eq(%w(OOOOO OOOOO OOOOO))
    end

    it 'should raise an exception for invalid clear command format' do
      expect { described_class.new('C @##').perform }.
        to raise_error(Commands::CommandError, "Invalid Clear command format in line: 'C @##'")
    end

    it 'should raise an exception for clear table on empty layout' do
      expect { described_class.new('C').perform }.
        to raise_error(Commands::CommandError, "Can't clear the table for no image in line: 'C'")
    end
  end
end
