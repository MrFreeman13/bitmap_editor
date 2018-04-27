require_relative '../../lib/commands/pixel'

describe Commands::Pixel do
  describe '#valid' do
    let(:layout) { %w(OOOO OOOO OOOO VVVV WWWW) }

    describe '#valid_format?' do
      it 'should validate valid command line' do
        command_line = described_class.new('L 3 2 E', layout)
        expect(command_line.valid?).to be true
      end

      it 'should invalidate command line in wrong format' do
        command_line = described_class.new('L 3 2 2', layout)
        expect(command_line.valid?).to be false
      end
    end

    describe '#valid_params?' do
      it 'should invalidate command line with out of current image coordinates' do
        command_line = described_class.new('L 10 30 W', layout)
        expect(command_line.valid?).to be false
      end
    end
  end
end
