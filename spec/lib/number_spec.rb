# frozen_string_literal: true

require 'number'
require 'support/helpers/token_helper'

RSpec.describe Number do
  subject(:number) { described_class.new(token) }

  let(:token) { integer_token(2) }

  describe '#initialize' do
    it { is_expected.to have_attributes(value: 2) }
  end
end
