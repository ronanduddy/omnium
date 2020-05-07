# frozen_string_literal: true

require 'binary_operator'
require 'support/helpers/token_helper'

RSpec.describe BinaryOperator do
  subject(:binary_operator) { described_class.new(left, operator, right) }

  let(:left) { integer_token(2) }
  let(:operator) { plus_token }
  let(:right) { integer_token(5) }

  describe '#initialize' do
    it { is_expected.to have_attributes(left: left, operator: operator, right: right) }
  end
end
