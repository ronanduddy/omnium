# frozen_string_literal: true

require 'common'
require 'lexer'

RSpec.describe Lexer do
  describe '.new' do
    subject(:new) { described_class.new('text') }

    it { is_expected.to be_a Lexer::Core }
  end
end
