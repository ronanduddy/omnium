# frozen_string_literal: true

require 'pluck/common'
require 'pluck/parser'

RSpec.describe Pluck::Parser do
  describe '.new' do
    subject(:new) { described_class.new('lexer') }

    it { is_expected.to be_a described_class::Core }
  end
end
