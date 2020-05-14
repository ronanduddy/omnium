# frozen_string_literal: true

require 'parser/ast/base'
require 'parser/ast/variable'
require 'support/helpers/token_helper'

RSpec.describe Parser::AST::Variable do
  subject(:variable) { described_class.new(identifer) }

  let(:identifer) { identifier_token 'foo' }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(variable.name).to eq 'foo'
    end
  end
end
