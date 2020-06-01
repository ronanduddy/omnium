# frozen_string_literal: true

require 'pluck/parser/ast/base'
require 'pluck/parser/ast/compound'

RSpec.describe Pluck::Parser::AST::Compound do
  subject(:compound) { described_class.new }

  describe '#initialize' do
    it { is_expected.to have_attributes(children: []) }
  end

  describe '#append' do
    subject(:append) { compound.append(nodes) }

    let(:nodes) { [1, 2, 3] }

    it { expect(append.children).to contain_exactly(1, 2, 3) }
  end
end
