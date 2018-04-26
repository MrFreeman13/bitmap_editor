require_relative '../../lib/commands/show'

describe Commands::Show do
  describe '#valid' do
    describe '#valid_format?' do
      it 'should validate valid command line' do
        command_line = described_class.new('S')
        expect(command_line.valid?).to be true
      end

      it 'should invalidate nil command line' do
        command_line = described_class.new(nil)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with extra character at the end' do
        command_line = described_class.new('S^')
        expect(command_line.valid?).to be false
      end
    end

    describe '#perform' do
      it 'should show the content of the current image' do
        image = %w(OOOO CCCC OKKO)
        expect { described_class.new('S', image).perform }.to output("OOOO\nCCCC\nOKKO\n").to_stdout
      end
    end
  end
end
