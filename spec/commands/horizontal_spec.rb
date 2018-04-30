require_relative '../../lib/commands/horizontal/horizontal'

describe Commands::Horizontal do
  describe '#valid' do
    let(:layout) { %w(OOOOOO XXXXXX OOOOOO) }

    describe '#valid_format?' do
      it 'should validate valid command line' do
        command_line = described_class.new('H 2 4 2 J', layout)
        expect(command_line.valid?).to be true
      end

      it 'should invalidate command line in wrong format' do
        command_line = described_class.new('H 1 3 L W', layout)
        expect(command_line.valid?).to be false
      end
    end

    describe '#valid_params?' do
      it 'should invalidate command line if Y coordinate is out of image' do
        command_line = described_class.new('H 2 4 9 U', layout)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line if X1 coordinate is out of image' do
        command_line = described_class.new('H 8 4 2 U', layout)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line if X2 coordinate is out of image' do
        command_line = described_class.new('H 2 13 2 U', layout)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line if X1 and X2 coordinates are equal' do
        command_line = described_class.new('H 3 3 2 U', layout)
        expect(command_line.valid?).to be false
      end
    end
  end

  describe '#perform' do
    let(:layout) { %w(OOOOOOO XXXXXXX OOOOOOO OOOOOOO) }

    it 'should draw a horizontal segment in colour S in row 3 between columns 2 and 6' do
      updated_layout = described_class.new('H 2 6 3 S', layout).perform
      expect(updated_layout).to eq(%w(OOOOOOO XXXXXXX OSSSSSO OOOOOOO))
    end

    it 'should draw a horizontal segment in colour K in row 4 between columns 5 and 3' do
      updated_layout = described_class.new('H 5 3 4 K', layout).perform
      expect(updated_layout).to eq(%w(OOOOOOO XXXXXXX OOOOOOO OOKKKOO))
    end

    it 'should raise an exception if X1 X2 columns are out of image' do
      expect { described_class.new('H 9 10 3 S', layout).perform }.
        to raise_error(StandardError, 'Invalid Horizontal command coordinates')
    end

    it 'should raise an exception if X1 X2 columns has equal numbers' do
      expect { described_class.new('H 3 3 1 S', layout).perform }.
        to raise_error(StandardError, 'Invalid Horizontal command coordinates')
    end

    it 'should raise an exception if command has wrong format' do
      expect { described_class.new('H 2 6 3 1', layout).perform }.
        to raise_error(StandardError, 'Invalid Horizontal command format')
    end
  end
end
