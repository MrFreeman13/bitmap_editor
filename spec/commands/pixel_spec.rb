require_relative '../../lib/commands/pixel/pixel'

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

  describe '#perform' do
    let(:layout) { %w(OOOO OOOO OOOO) }

    it 'should colour pixel XY with presented colour' do
      updated_layout = described_class.new('L 1 3 A', layout).perform
      expect(updated_layout).to eq(%w(OOOO OOOO AOOO))
    end

    it 'should raise an exception if XY pixel is out of image' do
      expect { described_class.new('L 10 3 A', layout).perform }.
        to raise_error(StandardError, 'Invalid Pixel command coordinates - pixel is out of image')
    end

    it 'should raise an exception if command has wrong format' do
      expect { described_class.new('L 3 3 q', layout).perform }.
        to raise_error(StandardError, 'Invalid Pixel command format')
    end
  end
end
