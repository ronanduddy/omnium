# frozen_string_literal: true

# frozen_text_literal: true

require 'common'
require 'lexer'
require 'support/matchers/token'

RSpec.describe Lexer::Core do
  subject(:lex) { described_class.new(text) }

  describe '#next_token' do
    context 'when spaces' do
      let(:text) { '14 + 2 * 3 - 6 / 2' }

      it 'returns the correct tokens' do
        expect(lex.next_token).to be_an_integer_token 14
        expect(lex.next_token).to be_a_plus_token
        expect(lex.next_token).to be_an_integer_token 2
        expect(lex.next_token).to be_a_multiply_token
        expect(lex.next_token).to be_an_integer_token 3
        expect(lex.next_token).to be_a_minus_token
        expect(lex.next_token).to be_an_integer_token 6
        expect(lex.next_token).to be_a_divide_token
        expect(lex.next_token).to be_an_integer_token 2
        expect(lex.next_token).to be_an_eof_token
      end
    end

    context 'when no spaces' do
      let(:text) { '14+2*3-6/2' }

      it 'returns the correct tokens' do
        expect(lex.next_token).to be_an_integer_token 14
        expect(lex.next_token).to be_a_plus_token
        expect(lex.next_token).to be_an_integer_token 2
        expect(lex.next_token).to be_a_multiply_token
        expect(lex.next_token).to be_an_integer_token 3
        expect(lex.next_token).to be_a_minus_token
        expect(lex.next_token).to be_an_integer_token 6
        expect(lex.next_token).to be_a_divide_token
        expect(lex.next_token).to be_an_integer_token 2
        expect(lex.next_token).to be_an_eof_token
      end
    end

    context 'using parentheses' do
      let(:text) { '7 + 3 * (10 / (12 / (3 + 1) - 1))' }

      it 'returns the correct tokens' do
        expect(lex.next_token).to be_an_integer_token 7
        expect(lex.next_token).to be_a_plus_token
        expect(lex.next_token).to be_an_integer_token 3
        expect(lex.next_token).to be_a_multiply_token
        expect(lex.next_token).to be_a_left_parenthesis_token
        expect(lex.next_token).to be_an_integer_token 10
        expect(lex.next_token).to be_a_divide_token
        expect(lex.next_token).to be_a_left_parenthesis_token
        expect(lex.next_token).to be_an_integer_token 12
        expect(lex.next_token).to be_a_divide_token
        expect(lex.next_token).to be_a_left_parenthesis_token
        expect(lex.next_token).to be_an_integer_token 3
        expect(lex.next_token).to be_a_plus_token
        expect(lex.next_token).to be_an_integer_token 1
        expect(lex.next_token).to be_a_right_parenthesis_token
        expect(lex.next_token).to be_a_minus_token
        expect(lex.next_token).to be_an_integer_token 1
        expect(lex.next_token).to be_a_right_parenthesis_token
        expect(lex.next_token).to be_a_right_parenthesis_token
        expect(lex.next_token).to be_an_eof_token
      end
    end

    context 'with program definition' do
      let(:text) { 'begin a := 2; end.' }

      it 'returns the correct tokens' do
        expect(lex.next_token).to be_a_begin_token
        expect(lex.next_token).to be_an_identifier_token 'a'
        expect(lex.next_token).to be_an_assignment_token
        expect(lex.next_token).to be_an_integer_token 2
        expect(lex.next_token).to be_a_semicolon_token
        expect(lex.next_token).to be_an_end_token
        expect(lex.next_token).to be_a_dot_token
        expect(lex.next_token).to be_an_eof_token
      end
    end

    context 'with invalid text' do
      let(:text) { '🧗' }

      it { expect { lex.next_token }.to raise_error(described_class::LexerError) }
    end
  end
end
