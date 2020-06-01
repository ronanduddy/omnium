# frozen_string_literal: true

# frozen_text_literal: true

require 'pluck/common'
require 'pluck/lexer'
require 'support/matchers/token'

RSpec.describe Pluck::Lexer::Core do
  subject(:lex) { described_class.new(text) }

  describe '#next_token' do
    context 'program definition' do
      let(:text) do
        "program pancake;\n" \
        "var\n" \
          "    a, b : int;\n" \
          "    y    : float;\n" \
        "begin # a comment ...\n" \
          "a := 2;\n" \
          "b := 10 * a + 10 * a / 4;\n" \
          "y := 20.0 / 7.0 + 3.14;\n" \
        'end.'
      end

      it 'returns the correct tokens' do
        # program test;
        expect(lex.next_token).to be_a_program_token
        expect(lex.next_token).to be_a_identifier_token 'pancake'
        expect(lex.next_token).to be_a_semicolon_token
        # var
        expect(lex.next_token).to be_a_var_token
        # 'a, b : int;
        expect(lex.next_token).to be_a_identifier_token 'a'
        expect(lex.next_token).to be_a_comma_token
        expect(lex.next_token).to be_a_identifier_token 'b'
        expect(lex.next_token).to be_a_colon_token
        expect(lex.next_token).to be_a_int_token
        expect(lex.next_token).to be_a_semicolon_token
        # y    : float;
        expect(lex.next_token).to be_a_identifier_token 'y'
        expect(lex.next_token).to be_a_colon_token
        expect(lex.next_token).to be_a_float_token
        expect(lex.next_token).to be_a_semicolon_token
        # begin # comment here\n
        expect(lex.next_token).to be_a_begin_token
        # a := 2;
        expect(lex.next_token).to be_a_identifier_token 'a'
        expect(lex.next_token).to be_a_assignment_token
        expect(lex.next_token).to be_a_integer_token 2
        expect(lex.next_token).to be_a_semicolon_token
        # 'b := 10 * a + 10 * a / 4;
        expect(lex.next_token).to be_a_identifier_token 'b'
        expect(lex.next_token).to be_a_assignment_token
        expect(lex.next_token).to be_a_integer_token 10
        expect(lex.next_token).to be_a_multiply_token
        expect(lex.next_token).to be_a_identifier_token 'a'
        expect(lex.next_token).to be_a_plus_token
        expect(lex.next_token).to be_a_integer_token 10
        expect(lex.next_token).to be_a_multiply_token
        expect(lex.next_token).to be_a_identifier_token 'a'
        expect(lex.next_token).to be_a_divide_token
        expect(lex.next_token).to be_a_integer_token 4
        expect(lex.next_token).to be_a_semicolon_token
        # y := 20 / 7 + 3.14;
        expect(lex.next_token).to be_a_identifier_token 'y'
        expect(lex.next_token).to be_a_assignment_token
        expect(lex.next_token).to be_a_real_token 20.0
        expect(lex.next_token).to be_a_divide_token
        expect(lex.next_token).to be_a_real_token 7.0
        expect(lex.next_token).to be_a_plus_token
        expect(lex.next_token).to be_a_real_token 3.14
        expect(lex.next_token).to be_a_semicolon_token
        # end.
        expect(lex.next_token).to be_a_end_token
        expect(lex.next_token).to be_a_dot_token
        expect(lex.next_token).to be_a_eof_token
      end
    end

    context 'arithmetic' do
      context 'when spaces' do
        let(:text) { '14 + 2 * 3 - 6 / 2' }

        it 'returns the correct tokens' do
          expect(lex.next_token).to be_a_integer_token 14
          expect(lex.next_token).to be_a_plus_token
          expect(lex.next_token).to be_a_integer_token 2
          expect(lex.next_token).to be_a_multiply_token
          expect(lex.next_token).to be_a_integer_token 3
          expect(lex.next_token).to be_a_minus_token
          expect(lex.next_token).to be_a_integer_token 6
          expect(lex.next_token).to be_a_divide_token
          expect(lex.next_token).to be_a_integer_token 2
          expect(lex.next_token).to be_a_eof_token
        end
      end

      context 'when no spaces' do
        let(:text) { '14+2*3-6/2' }

        it 'returns the correct tokens' do
          expect(lex.next_token).to be_a_integer_token 14
          expect(lex.next_token).to be_a_plus_token
          expect(lex.next_token).to be_a_integer_token 2
          expect(lex.next_token).to be_a_multiply_token
          expect(lex.next_token).to be_a_integer_token 3
          expect(lex.next_token).to be_a_minus_token
          expect(lex.next_token).to be_a_integer_token 6
          expect(lex.next_token).to be_a_divide_token
          expect(lex.next_token).to be_a_integer_token 2
          expect(lex.next_token).to be_a_eof_token
        end
      end

      context 'using parentheses' do
        let(:text) { '7 + 3 * (10 / (12 / (3 + 1) - 1))' }

        it 'returns the correct tokens' do
          expect(lex.next_token).to be_a_integer_token 7
          expect(lex.next_token).to be_a_plus_token
          expect(lex.next_token).to be_a_integer_token 3
          expect(lex.next_token).to be_a_multiply_token
          expect(lex.next_token).to be_a_left_parenthesis_token
          expect(lex.next_token).to be_a_integer_token 10
          expect(lex.next_token).to be_a_divide_token
          expect(lex.next_token).to be_a_left_parenthesis_token
          expect(lex.next_token).to be_a_integer_token 12
          expect(lex.next_token).to be_a_divide_token
          expect(lex.next_token).to be_a_left_parenthesis_token
          expect(lex.next_token).to be_a_integer_token 3
          expect(lex.next_token).to be_a_plus_token
          expect(lex.next_token).to be_a_integer_token 1
          expect(lex.next_token).to be_a_right_parenthesis_token
          expect(lex.next_token).to be_a_minus_token
          expect(lex.next_token).to be_a_integer_token 1
          expect(lex.next_token).to be_a_right_parenthesis_token
          expect(lex.next_token).to be_a_right_parenthesis_token
          expect(lex.next_token).to be_a_eof_token
        end
      end
    end

    context 'with invalid text' do
      let(:text) { '🧗' }

      it { expect { lex.next_token }.to raise_error(described_class::LexerError) }
    end
  end
end
