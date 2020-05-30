# frozen_string_literal: true

require 'cli'

RSpec.describe CLI do
  describe '.new' do
    subject(:new) { described_class.new(['test.plk']) }

    it { is_expected.to be_a CLI::Core }
  end
end
