# frozen_string_literal: true

require 'pluck/repl'

RSpec.describe Pluck::REPL do
  subject(:repl) { described_class.new }

  describe '.run' do
    subject(:run) { described_class.run(args) }

    context 'with an empty array' do
      let(:args) { [] }

      it 'calls run_repl' do
        expect_any_instance_of(described_class).to receive(:run_repl)
        run
      end
    end

    context 'with an array of arguments' do
      let(:args) { ['filename'] }

      it 'calls run_from_file' do
        expect_any_instance_of(described_class).to receive(:run_from_file)
        run
      end
    end
  end

  describe '#run_repl' do
    subject(:run_repl) { repl.run_repl }

    before do
      allow_any_instance_of(Object).to receive(:gets).and_return(
        double(String, chomp: input),
        double(String, chomp: 'exit')
      )
    end

    context 'with valid input' do
      let(:input) { 'begin a := 1 end.' }

      specify 'output is as expected' do
        expect { run_repl }.to output("pluck> {:a=>1}\npluck> ").to_stdout
      end
    end

    context 'with invalid input' do
      let(:input) { 'invalid input' }

      specify 'output is as expected' do
        output = "pluck> Variable 'invalid' not found\npluck> "
        expect { run_repl }.to output(output).to_stdout
      end
    end
  end

  describe '#run_from_file' do
    subject(:run_from_file) { repl.run_from_file(filename) }

    context 'with valid input' do
      let(:filename) { 'hello.plk' }

      specify 'output is as expected' do
        output = "{:number=>2, :a=>2, :b=>25, :c=>27, :x=>11}\n"
        expect { run_from_file }.to output(output).to_stdout
      end
    end
  end
end
