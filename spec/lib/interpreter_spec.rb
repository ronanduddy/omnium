# frozen_string_literal: true

require 'common'
require 'interpreter'

RSpec.describe Interpreter do
  describe '.new' do
    subject(:new) { described_class.new('parser') }

    it { is_expected.to be_a Interpreter::Core }
  end
end
