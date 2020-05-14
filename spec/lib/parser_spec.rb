# frozen_string_literal: true

require 'common'
require 'parser'

RSpec.describe Parser do
  describe '.new' do
    subject(:new) { described_class.new('lexer') }

    it { is_expected.to be_a Parser::Core }
  end
end
