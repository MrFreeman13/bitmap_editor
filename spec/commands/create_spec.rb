require_relative '../../lib/commands/create'

describe Commands::Create do
  describe '#valid' do
    describe '#valid_format?' do
      it 'should validate valid command line' do
        create_command_inst = described_class.new('I 10 20')
        expect(create_command_inst.valid?).to be true
      end

      it 'should invalidate command line with extra space at the end' do
        create_command_inst = described_class.new('I 10 20 ')
        expect(create_command_inst.valid?).to be false
      end

      it 'should invalidate command line with non digit coordinates' do
        create_command_inst = described_class.new('I $ @')
        expect(create_command_inst.valid?).to be false
      end

      it 'should invalidate command line with only one coordinate' do
        create_command_inst = described_class.new('I 1020')
        expect(create_command_inst.valid?).to be false
      end

      it 'should invalidate command line with 3 coordinates' do
        create_command_inst = described_class.new('I 10 20 49')
        expect(create_command_inst.valid?).to be false
      end
    end

    describe '#valid_params?' do
      it 'should invalidate command line with both out of range coordinates' do
        create_command_inst = described_class.new('I 260 0')
        expect(create_command_inst.valid?).to be false
      end

      it 'should invalidate command line with out of range coordinate n' do
        create_command_inst = described_class.new('I 500 20')
        expect(create_command_inst.valid?).to be false
      end

      it 'should invalidate command line with out of range coordinate m' do
        create_command_inst = described_class.new('I 10 700')
        expect(create_command_inst.valid?).to be false
      end
    end
  end
end
