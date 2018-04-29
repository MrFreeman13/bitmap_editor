require_relative '../../lib/commands/vertical'

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
end
