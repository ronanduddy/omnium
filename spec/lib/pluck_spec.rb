# frozen_string_literal: true

require 'pluck'

RSpec.describe Pluck do
  describe '#execute' do
    specify 'output is as expected' do
      output = "{:a=>2, :b=>25, :y=>5.997142857142857}\n"      
      expect { execute(['hello.plk']) }.to output(output).to_stdout
    end
  end
end
