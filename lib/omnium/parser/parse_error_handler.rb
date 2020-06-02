# frozen_string_literal: true

module Omnium
  module Parser
    # The module responsible for generating ParseErrors
    module ParseErrorHandler
      def error(message = nil, expected_type: nil, actual_type: nil)
        # a dirty sort of arg list...
        raise ParseError.new(
          actual_type: actual_type,
          expected_type: expected_type,
          message: message
        )
      end

      # could possibly break this out if desired...
      class ParseError < StandardError
        attr_reader :actual_type, :expected_type

        def initialize(**args)
          @actual_type = args[:actual_type]
          @expected_type = args[:expected_type]

          super(args[:message] || default_message)
        end

        private

        def default_message
          template = "Expecting token type(s) '%s', got '%s'."
          format(template, sanitised_expected_type, @actual_type)
        end

        def sanitised_expected_type
          return @expected_type.to_s if @expected_type.is_a? Symbol

          @expected_type.join(', ')
        end
      end
    end
  end
end
