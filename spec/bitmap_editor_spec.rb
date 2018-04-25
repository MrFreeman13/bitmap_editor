require_relative '../lib/bitmap_editor'

describe BitmapEditor do
  subject(:bitmap_editor) { described_class.new }

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
