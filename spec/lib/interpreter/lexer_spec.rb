# frozen_string_literal: true

# frozen_text_literal: true

require 'interpreter/lexer'
require 'support/matchers/token'

RSpec.describe Interpreter::Lexer do
  subject(:lexer) { described_class.new(text) }

  describe '#next_token' do
    context 'when spaces' do
      let(:text) { '14 + 2 * 3 - 6 / 2' }

      it 'returns the correct tokens' do
        expect(lexer.next_token).to be_an_integer_token 14
        expect(lexer.next_token).to be_a_plus_token
        expect(lexer.next_token).to be_an_integer_token 2
        expect(lexer.next_token).to be_a_multiply_token
        expect(lexer.next_token).to be_an_integer_token 3
        expect(lexer.next_token).to be_a_minus_token
        expect(lexer.next_token).to be_an_integer_token 6
        expect(lexer.next_token).to be_a_divide_token
        expect(lexer.next_token).to be_an_integer_token 2
        expect(lexer.next_token).to be_an_eof_token
      end
    end

    context 'when no spaces' do
      let(:text) { '14+2*3-6/2' }

      it 'returns the correct tokens' do
        expect(lexer.next_token).to be_an_integer_token 14
        expect(lexer.next_token).to be_a_plus_token
        expect(lexer.next_token).to be_an_integer_token 2
        expect(lexer.next_token).to be_a_multiply_token
        expect(lexer.next_token).to be_an_integer_token 3
        expect(lexer.next_token).to be_a_minus_token
        expect(lexer.next_token).to be_an_integer_token 6
        expect(lexer.next_token).to be_a_divide_token
        expect(lexer.next_token).to be_an_integer_token 2
        expect(lexer.next_token).to be_an_eof_token
      end
    end

    context 'with invalid text' do
      let(:text) { 'invalid' }

      it { expect { lexer.next_token }.to raise_error(described_class::LexerError) }
    end
  end
end
