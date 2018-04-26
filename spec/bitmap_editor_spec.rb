require_relative '../lib/bitmap_editor'

describe BitmapEditor do
  subject(:bitmap_editor) { described_class.new }

  describe 'Bitmap output' do
    it 'should print an error if file doesnt exist' do
      expect { subject.run(nil) }.to output("please provide correct file\n").to_stdout
    end

    it 'should print an error if file starts with non-char symbol' do
      expect { subject.run('spec/fixtures/incorrect_content.txt') }.to output("unrecognised command :(\n").to_stdout
    end

    it 'should pass if file has correct command' do
      expect { subject.run('spec/fixtures/correct_content.txt') }.to output("There is no image\n").to_stdout
    end
  end

  describe 'layout' do
    it 'should have a layout for correct input file' do
      subject.run('spec/fixtures/correct_content.txt')
      expect(subject.layout).to be_truthy
    end

    it 'should have a layout for incorrect input file' do
      subject.run('spec/fixtures/incorrect_content.txt')
      expect(subject.layout).to be_truthy
    end
  end

  describe 'create command' do
    it 'should process create command for correct input file' do
      subject.run('spec/fixtures/commands/create/valid.txt')
      expect(subject.layout).to eq(%w(OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO))
    end

    it 'should process create command for incorrect input file 1' do
      expect { subject.run('spec/fixtures/commands/create/out_of_range_coordinates.txt') }.
        to raise_error(StandardError, 'Invalid Create command coordinates: out of allowed range')
    end

    it 'should process I command for incorrect input file 2' do
      expect { subject.run('spec/fixtures/commands/create/invalid_format.txt') }.
        to raise_error(StandardError, 'Invalid Create command format')
    end
  end
end
