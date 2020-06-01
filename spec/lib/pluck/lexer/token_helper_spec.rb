# frozen_string_literal: true

# frozen_text_literal: true

require 'pluck/common'
require 'pluck/lexer/token'
require 'pluck/lexer/token_helper'
require 'support/matchers/token'

RSpec.describe Pluck::Lexer::TokenHelper do
  let(:dummy) do
    class Dummy
      include Pluck::Lexer::TokenHelper
    end.new
  end

  describe 'token creation' do
    Pluck::Common::VALUE_BASED_TOKENS.each do |token|
      context "#new_#{token[:type]}_token" do
        subject { dummy.send("new_#{token[:type]}_token") }

        it { is_expected.to be_a_token(token[:type], token[:value]) }
      end
    end

    Pluck::Common::PARAMETERISED_TOKENS.each do |token|
      context "#new_#{token[:type]}_token(:foo)" do
        subject { dummy.send("new_#{token[:type]}_token", :foo) }

        it { is_expected.to be_a_token(token[:type], :foo) }
      end
    end

    Pluck::Common::NIL_VALUE_TOKENS.each do |token|
      context "#new_#{token[:type]}_token" do
        subject { dummy.send("new_#{token[:type]}_token") }

        it { is_expected.to be_a_token(token[:type], nil) }
      end
    end

    Pluck::Common::RESERVED_KEYWORDS.each_pair do |key, value|
      context "#new_#{key}_token" do
        subject { dummy.send("new_#{key}_token") }

        it { is_expected.to be_a_token(key, value) }
      end
    end
  end
end
