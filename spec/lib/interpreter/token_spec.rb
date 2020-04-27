# frozen_string_literal: true

require 'interpreter/token'

RSpec.describe Interpreter::Token do
  subject(:token) { described_class.new(type, value) }

  let(:type) { :integer }
  let(:value) { 4 }

  describe '#initialize' do
    it { is_expected.to have_attributes(type: :integer, value: 4) }
  end

  describe '#operator?' do
    subject(:operator?) { token.operator? }

    context 'with valid operator' do
      let(:type) { :plus }
      let(:value) { '+' }

      it { is_expected.to be true }
    end

    context 'with invalid operator' do
      let(:type) { :derp }
      let(:value) { ']' }

      it { is_expected.to be false }
    end
  end

  describe '#eof?' do
    subject(:eof?) { token.eof? }

    context 'when not eof token' do
      let(:type) { :plus }
      let(:value) { '+' }

      it { is_expected.to be false }
    end

    context 'when eof token' do
      let(:type) { :eof }
      let(:value) { nil }

      it { is_expected.to be true }
    end
  end
end
