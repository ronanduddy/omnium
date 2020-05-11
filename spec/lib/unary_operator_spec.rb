# frozen_string_literal: true

require 'unary_operator'
require 'support/helpers/token_helper'

RSpec.describe UnaryOperator do
  subject(:unary_operator) { described_class.new(operator, operand) }

  let(:operator) { minus_token }
  let(:operand) { integer_token(5) }

  describe '#initialize' do
    it { is_expected.to have_attributes(operator: operator, operand: operand) }
  end
end
