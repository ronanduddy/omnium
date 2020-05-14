# frozen_string_literal: true

# frozen_text_literal: true

require 'common'
require 'support/matchers/token'

RSpec.describe Common do
  let(:dummy) do
    class Dummy
      include Common
    end.new
  end

  Common::VALUE_BASED_TOKENS.each_pair do |key, token|
    describe "##{key}?" do
      subject { dummy.send("#{key}?") }

      context "with token value '#{token[:value]}'" do
        before { allow(dummy).to receive(:token_entity) { token[:value] } }

        it { is_expected.to be true }
      end

      context "with token type :#{token[:type]}" do
        before { allow(dummy).to receive(:token_entity) { token[:type] } }

        it { is_expected.to be true }
      end

      context 'with invalid value or type' do
        before { allow(dummy).to receive(:token_entity) { 'invalid' } }

        it { is_expected.to be false }
      end
    end
  end

  Common::PARAMETERISED_TOKENS.each_pair do |key, token|
    describe "##{key}?" do
      subject { dummy.send("#{key}?") }

      context "with token type :#{token[:type]}" do
        before { allow(dummy).to receive(:token_entity) { token[:type] } }

        it { is_expected.to be true }
      end

      context 'with invalid type' do
        before { allow(dummy).to receive(:token_entity) { 'invalid' } }

        it { is_expected.to be false }
      end
    end
  end

  describe 'token creation' do
    Common::VALUE_BASED_TOKENS.each_pair do |key, token|
      context "##{key}_token" do
        subject { dummy.send("#{key}_token") }

        it { is_expected.to be_a_token(token[:type], token[:value]) }
      end
    end

    Common::PARAMETERISED_TOKENS.each_pair do |key, token|
      context "##{key}_token(:foo)" do
        subject { dummy.send("#{key}_token", :foo) }

        it { is_expected.to be_a_token(token[:type], :foo) }
      end
    end

    Common::RESERVED_KEYWORDS.each_pair do |key, value|
      context "##{key}_token" do
        subject { dummy.send("#{key}_token") }

        it { is_expected.to be_a_token(key, value) }
      end
    end
  end
end
