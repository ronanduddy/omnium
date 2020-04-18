# frozen_string_literal: true

require 'interpreter/parser'
require 'interpreter/token'

RSpec.describe Interpreter::Parser do
  subject(:parser) { described_class.new(tokens) }
  let(:token_class) { Interpreter::Token }

  describe '#evaluate' do
    subject(:evaluate) { parser.evaluate }

    {
      adding: { type: :plus, value: '+' },
      subtracting: { type: :minus, value: '-' },
      multipling: { type: :multiply, value: '*' },
      dividing: { type: :divide, value: '/' }
    }.each do |operation, token|
      context "when #{operation}" do
        let(:tokens) do
          [
            token_class.new(:integer, 9),
            token_class.new(token[:type], token[:value]),
            token_class.new(:integer, 3)
          ]
        end

        it 'returns the correct hash' do
          is_expected.to eq({ left: 9, operator: token[:value], right: 3 })
        end
      end
    end

    context 'with invalid tokens' do
      let(:tokens) do
        [
          token_class.new(:invalid, 9),
          token_class.new(:minus, '-'),
          token_class.new(:integer, 3)
        ]
      end

      it { expect { evaluate }.to raise_error described_class::ParserError }
    end
  end
end
