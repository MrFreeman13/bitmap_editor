require_relative '../lib/bitmap_editor'

describe BitmapEditor do
  subject(:bitmap_editor) { described_class.new }

  describe '#run' do
    let(:unrecognised_command) { "unrecognised command :(\n" }

    it 'should recognize the command if file has a correct command' do
      expect { subject.run('spec/fixtures/correct_content.txt') }.
        not_to output(unrecognised_command).to_stdout
    end

    it 'should print an error if file does not exist' do
      expect { subject.run(nil) }.
        to output("please provide correct file\n").to_stdout
    end

    it 'should print an error if file has unrecognised command' do
      expect { subject.run('spec/fixtures/incorrect_content.txt') }.
        to output(unrecognised_command).to_stdout
    end

    describe 'commands' do
      describe 'create' do
        it 'should process create command' do
          expect { subject.run('spec/fixtures/commands/create/create.txt') }.
            not_to output(unrecognised_command).to_stdout
        end

        it 'should process create command and update layout' do
          subject.run('spec/fixtures/commands/create/create.txt')
          expect(subject.layout).to eq(%w(OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO OOOOO))
        end
      end


      describe 'show' do
        it 'should process show command' do
          expect { subject.run('spec/fixtures/commands/show/show.txt') }.
            not_to output(unrecognised_command).to_stdout
        end
      end

      describe 'clear' do
        it 'should process clear command' do
          expect { subject.run('spec/fixtures/commands/clear/clear.txt') }.
            not_to output(unrecognised_command).to_stdout
        end
      end

      describe 'pixel' do
        it 'should process pixel command' do
          expect { subject.run('spec/fixtures/commands/pixel/pixel.txt') }.
            not_to output(unrecognised_command).to_stdout
        end
      end

      describe 'vertical' do
        it 'should process vertical command' do
          expect { subject.run('spec/fixtures/commands/vertical/vertical.txt') }.
            not_to output(unrecognised_command).to_stdout
        end
      end

      describe 'horizontal' do
        it 'should process horizontal command' do
          expect { subject.run('spec/fixtures/commands/horizontal/horizontal.txt') }.
            not_to output(unrecognised_command).to_stdout
        end
      end
    end
  end
end
