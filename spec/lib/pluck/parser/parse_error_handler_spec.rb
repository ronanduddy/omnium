# frozen_string_literal: true

require 'pluck/parser/parse_error_handler'

RSpec.describe Pluck::Parser::ParseErrorHandler do
  let(:dummy) do
    class Dummy
      include Pluck::Parser::ParseErrorHandler
    end.new
  end

  describe '#error' do
    context 'with message' do
      subject(:error) { dummy.error('error here!') }

      it 'raises with the correct message' do
        expect { error }.to raise_error(
          described_class::ParseError,
          'error here!'
        )
      end
    end

    context 'with expected_type and token' do
      subject(:error) do
        dummy.error(expected_type: expected_type, actual_type: 'not a plus token')
      end

      context 'when expected_type is a symbol' do
        let(:expected_type) { :plus }

        it 'raises with the correct message' do
          expect { error }.to raise_error(
            described_class::ParseError,
            "Expecting token type(s) 'plus', got 'not a plus token'."
          )
        end
      end

      context 'when expected_type is list of symbols' do
        let(:expected_type) { %i[plus minus divide] }

        it 'raises with the correct message' do
          expect { error }.to raise_error(
            described_class::ParseError,
            "Expecting token type(s) 'plus, minus, divide', got 'not a plus token'."
          )
        end
      end
    end
  end
end
