# frozen_string_literal: true

module Omnium
  module Parser
    # The parser will verify the format of a list of tokens (syntax analysis) by
    # 'recursive-descent'.
    class Core
      include Common
      include ParseErrorHandler
      include AST

      def initialize(lexer)
        @lexer = lexer
        @token = nil
        @consumed_token = nil
      end

      def parse
        @token = @lexer.next_token
        node = program

        error(expected_type: eof_token, actual_type: @token.type) unless eof?

        node
      end

      private

      def program
        # program : PROGRAM variable SEMI block DOT
        consume(program_token)
        name = identifier.name
        consume(semicolon_token)
        node = Program.new(name, block)
        consume(dot_token)

        node
      end

      def block
        # block : variable_declarations compound_statement
        Block.new(variable_declarations, compound_statement)
      end

      def variable_declarations
        # variable_declarations : VAR (variable_declaration SEMI)+
        #                       | empty
        declarations = []

        if var?
          consume(var_token)

          while identifier?
            declarations << variable_declaration
            consume(semicolon_token)
          end
        end

        declarations.flatten
      end

      def variable_declaration
        # variable_declaration : ID (COMMA ID)* COLON variable_data_type
        identifiers = [identifier]

        while comma?
          consume(comma_token)
          identifiers << identifier
        end

        consume(colon_token)

        data_type = variable_data_type
        identifiers.map { |identifier| VariableDeclaration.new(identifier, data_type) }
      end

      def variable_data_type
        # variable_data_type : INTEGER
        #                    | FLOAT
        if int?
          consume(int_token)
        elsif float?
          consume(float_token)
        end

        DataType.new(@consumed_token)
      end

      def compound_statement
        # compound_statement : BEGIN statement_list END
        consume(begin_token)
        nodes = statement_list
        consume(end_token)

        Compound.new.append(nodes)
      end

      def statement_list
        # statement_list : statement
        #               | statement SEMI statement_list
        nodes = [statement]

        while semicolon?
          consume(semicolon_token)
          nodes << statement
        end

        error("Invalid identifier found: #{@token.inspect}") if identifier?

        nodes
      end

      def statement
        # statement : compound_statement
        #           | assignment_statement
        #           | empty
        if begin?
          return compound_statement
        elsif identifier?
          return assignment_statement
        end

        empty
      end

      def assignment_statement
        # assignment_statement : variable ASSIGN expr
        left = identifier
        consume(assignment_token)

        Assignment.new(left, @consumed_token, expr)
      end

      def identifier
        # variable : ID
        node = Identifier.new(@token)
        consume(identifier_token)

        node
      end

      def empty
        # no operation rule
        NoOperation.new
      end

      def expr
        # expr : term ((PLUS | MINUS) term)*
        node = term

        while plus? || minus?
          if plus?
            consume(plus_token)
          elsif minus?
            consume(minus_token)
          end

          node = BinaryOperator.new(node, @consumed_token, term)
        end

        node
      end

      def term
        # term : factor ((MULTIPLY | DIVIDE) factor)*
        node = factor

        while multiply? || divide?
          if multiply?
            consume(multiply_token)
          elsif divide?
            consume(divide_token)
          end

          node = BinaryOperator.new(node, @consumed_token, factor)
        end

        node
      end

      def factor
        # factor : PLUS  factor
        #        | MINUS factor
        #        | INTEGER
        #        | LPAREN expr RPAREN
        #        | identifier
        if plus?
          consume(plus_token)
          return UnaryOperator.new(@consumed_token, factor)
        elsif minus?
          consume(minus_token)
          return UnaryOperator.new(@consumed_token, factor)
        elsif integer?
          consume(integer_token)
          return Number.new(@consumed_token)
        elsif real?
          consume(real_token)
          return Number.new(@consumed_token)
        elsif left_parenthesis?
          consume(left_parenthesis_token)
          node = expr
          consume(right_parenthesis_token)
          return node
        elsif identifier?
          return identifier
        end

        expected_types = [
          plus_token,
          minus_token,
          integer_token,
          real_token,
          left_parenthesis_token,
          right_parenthesis_token,
          identifier_token
        ]

        error(expected_type: expected_types, actual_type: @token.type)
      end

      def consume(type)
        # verify the type of @token and advance @token to next_token
        unless type == @token.type
          error(expected_type: type, actual_type: @token.type)
        end

        @consumed_token = @token
        @token = @lexer.next_token
      end
    end
  end
end
