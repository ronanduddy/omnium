# frozen_string_literal: true

RSpec.shared_examples 'tokens' do
  it 'returns valid tokens' do
    tokens.each_with_index do |token, index|
      expect(token.type).to eq expected[index][:type]
      expect(token.value).to eq expected[index][:value]
    end
  end
end
