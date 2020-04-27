# frozen_string_literal: true

require 'interpreter/lexer'
require 'support/matchers/token'

RSpec.describe Interpreter::Lexer do
  subject(:lexer) { described_class.new(string) }

  describe '#next_token' do
    {
      addition: { type: :plus, value: '+' },
      subtraction: { type: :minus, value: '-' },
      multiplication: { type: :multiply, value: '*' },
      division: { type: :divide, value: '/' }
    }.each do |operation, token|
      context "when the string is #{operation}" do
        {
          no_spaces: '%{l}%{o}%{r}',
          space_before: ' %{l}%{o}%{r}',
          space_after: '%{l}%{o}%{r} ',
          space_before_operator: '%{l} %{o}%{r}',
          space_after_operator: '%{l}%{o}% {r}',
          space_around_operator: '%{l} %{o} %{r}',
          multiple_spaces: '    %{l}    %{o}    %{r}    '
        }.each do |scenario, template|
          context "with #{scenario} for single digit operation" do
            let(:string) { format(template, l: 9, o: token[:value], r: 3) }

            it 'returns the correct tokens' do
              expect(lexer.next_token).to be_an_integer_token 9
              expect(lexer.next_token).to be_a_token token[:type], token[:value]
              expect(lexer.next_token).to be_an_integer_token 3
              expect(lexer.next_token).to be_an_eof_token
            end
          end

          context "with #{scenario} for multiple digit operation" do
            let(:string) { format(template, l: 99, o: token[:value], r: 33) }

            it 'returns the correct tokens' do
              expect(lexer.next_token).to be_an_integer_token 99
              expect(lexer.next_token).to be_a_token token[:type], token[:value]
              expect(lexer.next_token).to be_an_integer_token 33
              expect(lexer.next_token).to be_an_eof_token
            end
          end
        end
      end
    end

    context 'with arbitrary number of operands' do
      let(:string) { '1+2-3*4/5' }

      it 'returns the correct tokens' do
        expect(lexer.next_token).to be_an_integer_token 1
        expect(lexer.next_token).to be_a_plus_token
        expect(lexer.next_token).to be_an_integer_token 2
        expect(lexer.next_token).to be_a_minus_token
        expect(lexer.next_token).to be_an_integer_token 3
        expect(lexer.next_token).to be_a_multiply_token
        expect(lexer.next_token).to be_an_integer_token 4
        expect(lexer.next_token).to be_a_divide_token
        expect(lexer.next_token).to be_an_integer_token 5
        expect(lexer.next_token).to be_an_eof_token
      end
    end
  end
end
