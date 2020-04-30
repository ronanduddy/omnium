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

  describe '#eos?' do
    before { scanner.pointer = 31 }

    it { expect(scanner.eos?).to be true }
  end

  describe '#scan' do
    context 'with spaces' do
      let(:string) { ' 1 + 2 ' }

      it do
        expect(scanner.scan).to eq '1'
        expect(scanner.scan).to eq '+'
        expect(scanner.scan).to eq '2'
      end
    end

    context 'without spaces' do
      let(:string) { '1+2' }

      it { expect(scanner.scan).to eq '1+2' }
    end

    context 'with words' do
      it do
        expect(scanner.scan).to eq 'Hello'
        expect(scanner.scan).to eq 'there'
        expect(scanner.scan).to eq 'Ronan.'
        expect(scanner.scan).to eq 'How\'re'
        expect(scanner.scan).to eq 'you?'
        expect(scanner.scan).to be nil
      end
    end
  end
end
