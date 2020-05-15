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

  # below similar logic should be pulled into a helper or something

  Common::VALUE_BASED_TOKENS.each do |token|
    describe "##{token[:type]}?" do
      subject { dummy.send("#{token[:type]}?") }

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

    describe "##{token[:type]}_token" do
      context 'with no arguments' do
        subject { dummy.send("#{token[:type]}_token") }

        it 'defaults to return the token type' do
          is_expected.to be token[:type]
        end
      end

      context 'with argument :type' do
        subject { dummy.send("#{token[:type]}_token", :type) }

        it { is_expected.to be token[:type] }
      end

      context 'with argument :value' do
        subject { dummy.send("#{token[:type]}_token", :value) }

        it { is_expected.to be token[:value] }
      end

      context 'with invalid argument' do
        subject { dummy.send("#{token[:type]}_token", :food) }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

  Common::PARAMETERISED_TOKENS.each do |token|
    describe "##{token[:type]}?" do
      subject { dummy.send("#{token[:type]}?") }

      context "with token type :#{token[:type]}" do
        before { allow(dummy).to receive(:token_entity) { token[:type] } }

        it { is_expected.to be true }
      end

      context 'with invalid type' do
        before { allow(dummy).to receive(:token_entity) { 'invalid' } }

        it { is_expected.to be false }
      end
    end

    describe "##{token[:type]}_token" do
      subject { dummy.send("#{token[:type]}_token") }

      it { is_expected.to be token[:type] }
    end
  end

  Common::NIL_VALUE_TOKENS.each do |token|
    describe "##{token[:type]}?" do
      subject { dummy.send("#{token[:type]}?") }

      context "with token type :#{token[:type]}" do
        before { allow(dummy).to receive(:token_entity) { token[:type] } }

        it { is_expected.to be true }
      end

      context 'with invalid type' do
        before { allow(dummy).to receive(:token_entity) { 'invalid' } }

        it { is_expected.to be false }
      end
    end

    describe "##{token[:type]}_token" do
      subject { dummy.send("#{token[:type]}_token") }

      it { is_expected.to be token[:type] }
    end
  end

  Common::RESERVED_KEYWORDS.each_pair do |key, _value|
    describe "##{key}?" do
      subject { dummy.send("#{key}?") }

      context "with token type :#{key}" do
        before { allow(dummy).to receive(:token_entity) { key } }

        it { is_expected.to be true }
      end

      context 'with invalid type' do
        before { allow(dummy).to receive(:token_entity) { 'invalid' } }

        it { is_expected.to be false }
      end
    end

    describe "##{key}_token" do
      subject { dummy.send("#{key}_token") }

      it { is_expected.to be key }
    end
  end
end
