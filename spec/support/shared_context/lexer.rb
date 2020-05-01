# frozen_string_literal: true

require 'support/helpers/lexer_helper'

RSpec.shared_context 'lexer' do
  let(:lexer) { mocked_lexer }

  before do
    allow(lexer).to receive(:next_token).and_return(*tokens)
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'lexer', include_shared: true
end
