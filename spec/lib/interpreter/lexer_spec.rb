# frozen_string_literal: true

require 'interpreter/lexer'
require 'support/shared_examples/tokens'

RSpec.describe Interpreter::Lexer do
  subject(:lexer) { described_class.new(string) }

  describe '#tokens' do
    subject(:tokens) { lexer.tokens }

    {
      addition: { type: :plus, value: '+' },
      subtraction: { type: :minus, value: '-' },
      multiplication: { type: :multiply, value: '*' },
      division: { type: :divide, value: '/' }
    }.each do |operation, token|
      context "when the string is #{operation}" do
        {
          no_spaces: '%{l}%{o}%{r}',
          space_before: ' %{l}%{o}%{r}',
          space_after: '%{l}%{o}%{r} ',
          space_before_operator: '%{l} %{o}%{r}',
          space_after_operator: '%{l}%{o}% {r}',
          space_around_operator: '%{l} %{o} %{r}',
          multiple_spaces: '    %{l}    %{o}    %{r}    '
        }.each do |scenario, template|
          context "with #{scenario} for single digit operation" do
            let(:string) { format(template, l: 9, o: token[:value], r: 3) }

            include_examples 'tokens' do
              let(:expected) do
                [
                  { type: :integer, value: 9 },
                  { type: token[:type], value: token[:value] },
                  { type: :integer, value: 3 }
                ]
              end
            end
          end

          context "with #{scenario} for multiple digit operation" do
            let(:string) { format(template, l: 99, o: token[:value], r: 33) }

            include_examples 'tokens' do
              let(:expected) do
                [
                  { type: :integer, value: 99 },
                  { type: token[:type], value: token[:value] },
                  { type: :integer, value: 33 }
                ]
              end
            end
          end
        end
      end
    end

    context 'with arbitrary number of operands' do
      let(:string) { '1+2-3*4/5' }

      include_examples 'tokens' do
        let(:expected) do
          [
            { type: :integer, value: 1 },
            { type: :plus, value: '+' },
            { type: :integer, value: 2 },
            { type: :minus, value: '-' },
            { type: :integer, value: 3 },
            { type: :multiply, value: '*' },
            { type: :integer, value: 4 },
            { type: :divide, value: '/' },
            { type: :integer, value: 5 }
          ]
        end
      end
    end
  end
end
