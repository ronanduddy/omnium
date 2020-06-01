# frozen_string_literal: true

require 'pluck/common'
require 'pluck/interpreter'

RSpec.describe Pluck::Interpreter do
  describe '.new' do
    subject(:new) { described_class.new('parser') }

    it { is_expected.to be_a described_class::Core }
  end
end
