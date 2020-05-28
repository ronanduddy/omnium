# frozen_string_literal: true

require 'parser/ast/base'
require 'parser/ast/block'

RSpec.describe Parser::AST::Block do
  subject(:block) { described_class.new(variable_declarations, compound_statements) }

  let(:variable_declarations) { ['a int', 'b int'] }
  let(:compound_statements) { ['a=2', 'b=4'] }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(block.variable_declarations).to contain_exactly('a int', 'b int')
      expect(block.compound_statements).to contain_exactly('a=2', 'b=4')
    end
  end
end
