require_relative '../../lib/commands/show'

describe Commands::Show do
  describe '#valid' do
    describe '#valid_format?' do
      it 'should validate valid command line' do
        command_line = described_class.new('S')
        expect(command_line.valid?).to be true
      end

      it 'should invalidate command line with extra character at the end' do
        command_line = described_class.new('S^')
        expect(command_line.valid?).to be false
      end
    end
  end
end
