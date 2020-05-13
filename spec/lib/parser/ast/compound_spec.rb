# frozen_string_literal: true

require 'parser/ast/compound'

RSpec.describe Parser::AST::Compound do
  subject(:compound) { described_class.new }

  describe '#initialize' do
    it { is_expected.to have_attributes(children: []) }
  end
end
