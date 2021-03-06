require_relative '../../lib/commands/create/create'

describe Commands::Create do
  describe '#valid' do
    describe '#valid_format?' do
      it 'should validate valid command line' do
        command_line = described_class.new('I 10 20')
        expect(command_line.valid?).to be true
      end

      it 'should invalidate nil command line' do
        command_line = described_class.new(nil)
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with extra space at the end' do
        command_line = described_class.new('I 10 20 ')
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with non digit coordinates' do
        command_line = described_class.new('I $ @')
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with only one coordinate' do
        command_line = described_class.new('I 1020')
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with 3 coordinates' do
        command_line = described_class.new('I 10 20 49')
        expect(command_line.valid?).to be false
      end
    end

    describe '#valid_params?' do
      it 'should invalidate command line with both out of range coordinates' do
        command_line = described_class.new('I 260 0')
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with out of range coordinate n' do
        command_line = described_class.new('I 500 20')
        expect(command_line.valid?).to be false
      end

      it 'should invalidate command line with out of range coordinate m' do
        command_line = described_class.new('I 10 700')
        expect(command_line.valid?).to be false
      end
    end
  end

  describe '#perform' do
    it 'should return array for correct params' do
      layout = described_class.new('I 10 15').perform
      expect(layout.is_a?(Array)).to be true
    end

    it 'should create 3 * 4 image' do
      layout = described_class.new('I 4 3').perform
      expect(layout).to eq(%w(OOOO OOOO OOOO))
    end

    it 'should raise an exception if invalid command format' do
      expect { described_class.new('I 251 01 05 ').perform }.
        to raise_error(Commands::CommandError,
                       "Invalid Create command format in line: 'I 251 01 05 '")
    end

    it 'should raise an exception if out of range coordinates params' do
      expect { described_class.new('I 251 15').perform }.
        to raise_error(Commands::CommandError,
                       "Invalid Create command coordinates: out of allowed range in line: 'I 251 15'")
    end
  end
end
