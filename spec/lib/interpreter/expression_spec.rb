# frozen_string_literal: true

require 'interpreter/expression'

RSpec.describe Interpreter::Expression do
  describe '#evaluate' do
    subject(:evaluate) { described_class.new(terms).evaluate }

    {
      addition: { operator: '+', result: 12 },
      subtraction: { operator: '-', result: 6 },
      multiplication: { operator: '*', result: 27 },
      division: { operator: '/', result: 3 }
    }.each do |operation, data|
      context "when #{operation}" do
        let(:terms) { { left: 9, operator: data[:operator], right: 3 } }

        it { is_expected.to eq data[:result] }
      end
    end

    context 'when invalid' do
      let(:terms) { { left: 9, operator: 'i', right: 3 } }

      it { expect { evaluate }.to raise_error(described_class::OperatorError) }
    end
  end
end
