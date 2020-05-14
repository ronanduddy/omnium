# frozen_string_literal: true

# frozen_text_literal: true

require 'common'
require 'lexer/token'
require 'lexer/token_helper'
require 'support/matchers/token'

RSpec.describe Lexer::TokenHelper do
  let(:dummy) do
    class Dummy
      include Lexer::TokenHelper
    end.new
  end

  # probably 'not good' to refrence Common in this spec

  describe 'token creation' do
    Common::VALUE_BASED_TOKENS.each do |token|
      context "#new_#{token[:type]}_token" do
        subject { dummy.send("new_#{token[:type]}_token") }

        it { is_expected.to be_a_token(token[:type], token[:value]) }
      end
    end

    Common::PARAMETERISED_TOKENS.each do |token|
      context "#new_#{token[:type]}_token(:foo)" do
        subject { dummy.send("new_#{token[:type]}_token", :foo) }

        it { is_expected.to be_a_token(token[:type], :foo) }
      end
    end

    Common::RESERVED_KEYWORDS.each_pair do |key, value|
      context "#new_#{key}_token" do
        subject { dummy.send("new_#{key}_token") }

        it { is_expected.to be_a_token(key, value) }
      end
    end
  end
end
