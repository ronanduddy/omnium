# frozen_string_literal: true

require 'interpreter/lexer'

RSpec.describe Interpreter::Lexer do
  subject(:lexer) { described_class.new(string) }
  let(:token_class) { Interpreter::Token }

  describe '#tokens' do
    subject(:tokens) { lexer.tokens }

    {
      adding: { type: :plus, value: '+' },
      subtracting: { type: :minus, value: '-' },
      multipling: { type: :multiply, value: '*' },
      dividing: { type: :divide, value: '/' }
    }.each do |operation, token|
      context "when the input is #{operation}" do
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

            it 'tokenises the input' do
              left = tokens[0]
              expect(left).to be_an_instance_of(token_class)
              expect(left.type).to eq :integer
              expect(left.value).to eq 9

              operator = tokens[1]
              expect(operator).to be_an_instance_of(token_class)
              expect(operator.type).to eq token[:type]
              expect(operator.value).to eq token[:value]

              right = tokens[2]
              expect(right).to be_an_instance_of(token_class)
              expect(right.type).to eq :integer
              expect(right.value).to eq 3
            end
          end

          context "with #{scenario} for multiple digit operation" do
            let(:string) { format(template, l: 99, o: token[:value], r: 33) }

            it 'tokenises the input' do
              left = tokens[0]
              expect(left).to be_an_instance_of(token_class)
              expect(left.type).to eq :integer
              expect(left.value).to eq 99

              operator = tokens[1]
              expect(operator).to be_an_instance_of(token_class)
              expect(operator.type).to eq token[:type]
              expect(operator.value).to eq token[:value]

              right = tokens[2]
              expect(right).to be_an_instance_of(token_class)
              expect(right.type).to eq :integer
              expect(right.value).to eq 33
            end
          end
        end
      end
    end
  end
end
