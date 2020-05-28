# frozen_string_literal: true

require 'parser/ast/base'
require 'parser/ast/data_type'
require 'support/helpers/token_helper'

RSpec.describe Parser::AST::DataType do
  subject(:data_type) { described_class.new(token) }

  let(:token) { int_token }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(data_type.value).to eq 'int'
    end
  end
end
