# frozen_string_literal: true

require 'interpreter/scanner'

RSpec.describe Interpreter::Scanner do
  subject(:scanner) { described_class.new(string) }

  let(:string) { "Hello  there Ronan. How're you?" }

  describe '#initialize' do
    it 'has the following attributes' do
      is_expected.to have_attributes(
        string: "Hello  there Ronan. How're you?",
        pointer: 0
      )
    end
  end

  describe '#reset' do
    before { scanner.pointer = 3 }

    it { expect(scanner.reset).to eq 0 }
  end

  describe '#eos?' do
    before { scanner.pointer = 31 }

    it { expect(scanner.eos?).to be true }
  end

  describe '#next_char' do
    context 'when character is within string bounds' do
      it 'advances `pointer` and returns the character' do
        expect(scanner.next_char).to eq 'H'
        expect(scanner.pointer).to eq 1

        expect(scanner.next_char).to eq 'e'
        expect(scanner.pointer).to eq 2
      end
    end

    context 'when `pointer` is beyond the bounds of the string' do
      before { scanner.pointer = 32 }

      it { expect(scanner.next_char).to be nil }
    end
  end

  describe '#next_word' do
    context 'when word is within string bounds' do
      it 'advances `pointer` to be end of the word and returns the word' do
        expect(scanner.next_word).to eq 'Hello'
        expect(scanner.pointer).to eq 5

        expect(scanner.next_word).to eq 'there'
        expect(scanner.pointer).to eq 12
      end
    end

    context 'when word is within string bounds and including whitespace' do
      it 'advances `pointer` to be end of the word and returns the word' do
        expect(scanner.next_word(false)).to eq 'Hello'
        expect(scanner.pointer).to eq 5

        expect(scanner.next_word(false)).to be nil
        expect(scanner.pointer).to eq 5
      end
    end

    context 'when `pointer` is beyond the bounds of the string' do
      before { scanner.pointer = 32 }

      it { expect(scanner.next_word).to be nil }
    end
  end

  describe '#next_operator' do
    context 'when operator is within string bounds' do
      let(:string) { '1-1' }
      before { scanner.pointer = 1 }

      it 'advances `pointer` to be end of the operator and returns the operator' do
        expect(scanner.next_operator).to eq '-'
        expect(scanner.pointer).to eq 2
      end
    end

    context 'when operator is within string bounds' do
      let(:string) { '1 -1' }
      before { scanner.pointer = 1 }

      it 'advances `pointer` to be end of the operator and returns the operator' do
        expect(scanner.next_operator).to eq '-'
        expect(scanner.pointer).to eq 3
      end
    end
  end

  describe '#next_whitespace' do
    context 'when whitespace is within string' do
      let(:string) { '    hello' }

      it 'advances `pointer` to the end of the whitespace and returns the whitespace' do
        expect(scanner.next_whitespace).to eq '    '
        expect(scanner.pointer).to eq 4
      end
    end

    context 'when `pointer` is beyond the bounds of the string' do
      before { scanner.pointer = 32 }

      it { expect(scanner.next_whitespace).to be nil }
    end
  end
end
