# frozen_string_literal: true

require 'support/helpers/token_helper'

RSpec.describe Parser::AST::Number do
  subject(:number) { described_class.new(token) }

  let(:token) { integer_token 2 }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(number.value).to eq 2
    end
  end
end
