# frozen_string_literal: true

RSpec.shared_examples 'tokens' do
  it 'returns valid tokens' do
    expect(tokens.length).to eq expected_tokens.length

    expected_tokens.each_with_index do |expected_token, index|
      expect(tokens[index].type).to eq expected_token[:type]
      expect(tokens[index].value).to eq expected_token[:value]
    end
  end
end
