require_relative '../../lib/commands/vertical/vertical'

describe Commands::Vertical do
  describe '#valid' do
    let(:layout) { %w(OOOOO EEEEE JJJJJ OOOOO OOOOO) }

    describe '#valid_format?' do
      it 'should validate valid command line' do
        command_line = described_class.new('V 2 1 4 C', layout)
        expect(command_line.valid?).to be true
      end

      it 'should invalidate command line in wrong format' do
        command_line = described_class.new('V 3 3 W', layout)
        expect(command_line.valid?).to be false
      end
    end

    describe '#valid_params?' do
      it 'should invalidate command line if X coordinate is out of image' do
        command_line = described_class.new('V 7 1 4 Q', layout)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line if Y1 coordinate is out of image' do
        command_line = described_class.new('V 2 10 4 Q', layout)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line if Y2 coordinate is out of image' do
        command_line = described_class.new('V 2 1 9 Q', layout)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line if Y1 and Y2 coordinates are equal' do
        command_line = described_class.new('V 2 3 3 Q', layout)
        expect(command_line.valid?).to be false
      end
    end
  end

  describe '#perform' do
    let(:layout) { %w(AOOO OOOO OOOO OOOO OOOA) }

    it 'should draw a vertical segment in colour C in column 3 between 1 and 4 rows' do
      updated_layout = described_class.new('V 3 1 4 C', layout).perform
      expect(updated_layout).to eq(%w(AOCO OOCO OOCO OOCO OOOA))
    end

    it 'should raise an exception if Y1 Y2 rows are out of image' do
      expect { described_class.new('V 2 10 9 W', layout).perform }.
        to raise_error(Commands::CommandError, "Invalid Vertical command coordinates in line: 'V 2 10 9 W'")
    end

    it 'should raise an exception if Y1 Y2 rows has equal numbers' do
      expect { described_class.new('V 2 4 4 W', layout).perform }.
        to raise_error(Commands::CommandError, "Invalid Vertical command coordinates in line: 'V 2 4 4 W'")
    end

    it 'should raise an exception if command has wrong format' do
      expect { described_class.new('V 2 4 0 W', layout).perform }.
        to raise_error(Commands::CommandError, "Invalid Vertical command format in line: 'V 2 4 0 W'")
    end
  end
end
