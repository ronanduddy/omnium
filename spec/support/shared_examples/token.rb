# frozen_string_literal: true

RSpec.shared_examples 'a token' do |params|
  it "is a #{params[:type]} token with a #{params[:value]} value" do
    expect(token.type).to eq params[:type]
    expect(token.value).to eq params[:value]
  end
end
