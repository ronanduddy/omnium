# frozen_string_literal: true

require 'pluck/parser/ast/base'
require 'pluck/parser/ast/identifier'
require 'support/helpers/token_helper'

RSpec.describe Pluck::Parser::AST::Identifier do
  subject(:variable) { described_class.new(identifer) }

  let(:identifer) { identifier_token 'foo' }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(variable.name).to eq 'foo'
    end
  end
end
