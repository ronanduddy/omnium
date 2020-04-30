# frozen_string_literal: true

require 'interpreter/lexer'
require 'support/matchers/token'

RSpec.describe Interpreter::Lexer do
  subject(:lexer) { described_class.new(string) }

  describe '#next_token' do
    let(:string) { '1 + 2 - 3 * 4 / 5' }

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
