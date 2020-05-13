# frozen_string_literal: true

require 'parser/ast/assignment'
require 'support/helpers/token_helper'
require 'support/matchers/token'

RSpec.describe Parser::AST::Assignment do
  subject(:assignment) { described_class.new(left, operator, right) }

  let(:left) { identifier_token 'num' }
  let(:operator) { assignment_token }
  let(:right) { integer_token 5 }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(assignment.left).to be_an_identifier_token 'num'
      expect(assignment.operator).to be_an_assignment_token
      expect(assignment.right).to be_an_integer_token 5
    end
  end
end
