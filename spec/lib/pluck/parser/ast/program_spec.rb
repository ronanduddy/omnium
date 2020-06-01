# frozen_string_literal: true

require 'pluck/parser/ast/base'
require 'pluck/parser/ast/program'

RSpec.describe Pluck::Parser::AST::Program do
  subject(:program) { described_class.new(name, block) }

  let(:name) { 'pancake_town' }
  let(:block) { 'something' }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(program.name).to eq 'pancake_town'
      expect(program.block).to eq 'something'
    end
  end
end
