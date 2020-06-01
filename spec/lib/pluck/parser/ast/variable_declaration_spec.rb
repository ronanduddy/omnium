# frozen_string_literal: true

require 'pluck/parser/ast/base'
require 'pluck/parser/ast/variable_declaration'
require 'support/helpers/token_helper'
require 'support/matchers/token'

RSpec.describe Pluck::Parser::AST::VariableDeclaration do
  subject(:variable_declaration) { described_class.new(identifier, data_type) }

  let(:identifier) { identifier_token('num') }
  let(:data_type) { int_token }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(variable_declaration.identifier).to be_a_identifier_token 'num'
      expect(variable_declaration.data_type).to be_a_int_token
    end
  end
end
