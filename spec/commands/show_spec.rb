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

      it 'should show the message if image is empty' do
        expect { described_class.new('S').perform }.to output("The image is empty\n").to_stdout
      end

      it 'should raise an exception for fail validation while performing' do
        expect { described_class.new('S ').perform }.
          to raise_error(StandardError, 'Invalid Show command format')
      end
    end
  end
end
