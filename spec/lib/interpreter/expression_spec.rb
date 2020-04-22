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
        let(:terms) { [9, data[:operator], 3] }

        it { is_expected.to eq data[:result] }
      end
    end

    context 'when arbitrary number of terms' do
      context 'with plus and minus' do
        let(:terms) do
          [100, '+', 2, '+', 3, '+', 4, '-', 55, '-', 6, '-', 7, '-', 8, '-', 9]
        end

        it { is_expected.to eq 24 }
      end

      context 'with multiply and divide' do
        let(:terms) do
          [7, '*', 4, '/', 2, '*', 3]
        end

        it { is_expected.to eq 42 }
      end
    end

    context 'when invalid' do
      let(:terms) { [9, 'i', 3] }

      it { expect { evaluate }.to raise_error(described_class::OperatorError) }
    end
  end
end
