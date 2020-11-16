# frozen_string_literal: true

RSpec.describe CLI::Core do
  subject(:cli) { described_class.new(args) }

  describe '#run' do
    subject(:run) { cli.run }

    context 'with filename' do
      let(:args) { ['hello.om'] }

      it { is_expected.to eq({ a: 2, b: 25, y: 5.997142857142857 }) }
    end

    context 'with nil' do
      let(:args) { nil }

      it { expect { run }.to raise_error(described_class::CLIError) }
    end

    context 'with an empty array' do
      let(:args) { [] }

      it { expect { run }.to raise_error(described_class::CLIError) }
    end

    context 'with a non-existent file' do
      let(:args) { ['imaginary.plk'] }

      it { expect { run }.to raise_error(described_class::CLIError) }
    end
  end
end
