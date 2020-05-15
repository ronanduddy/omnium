# frozen_string_literal: true

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
    rescue ParseError => e
      # a little hack to allow the parser to parse either a program i.e.
      # 'begin ... end' or arithmetic e.g. '1+1'
      raise unless e.expected_type == begin_token

      expr
    end

    private

    def program
      # program : compound_statement DOT
      node = compound_statement
      consume(dot_token)

      node
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
      left = variable
      consume(assignment_token)

      Assignment.new(left, @consumed_token, expr)
    end

    def variable
      # variable : ID
      node = Variable.new(@token)
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
      #        | variable
      if plus?
        consume(plus_token)
        return UnaryOperator.new(@consumed_token, factor)
      elsif minus?
        consume(minus_token)
        return UnaryOperator.new(@consumed_token, factor)
      elsif integer?
        consume(integer_token)
        return Number.new(@consumed_token)
      elsif left_parenthesis?
        consume(left_parenthesis_token)
        node = expr
        consume(right_parenthesis_token)
        return node
      elsif identifier?
        return variable
      end

      expected_types = [
        plus_token,
        minus_token,
        integer_token,
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
