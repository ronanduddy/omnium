# frozen_string_literal: true

module Parser
  # The parser will verify the format of a list of tokens (syntax analysis) by
  # 'recursive-descent'.
  class Core
    include Common
    include AST

    class ParserError < StandardError; end

    def initialize(lexer)
      @lexer = lexer
      @token = nil
    end

    def parse
      @token = @lexer.next_token
      expr
    end

    private

    def expr
      # expr : term ((PLUS | MINUS) term)*
      node = term

      while plus? || minus?
        token = @token

        if plus?
          consume(plus_token)
        elsif minus?
          consume(minus_token)
        end

        node = BinaryOperator.new(node, token, term)
      end

      node
    end

    def term
      # term : factor ((MULTIPLY | DIVIDE) factor)*
      node = factor

      while multiply? || divide?
        token = @token

        if multiply?
          consume(multiply_token)
        elsif divide?
          consume(divide_token)
        end

        node = BinaryOperator.new(node, token, factor)
      end

      node
    end

    def factor
      # factor : (PLUS | MINUS) factor | INTEGER | LPAREN expr RPAREN
      token = @token
      node = nil # I don't think this should be nil; mirroring other methods for consistency. Should return early instead.

      if plus?
        operator = token
        consume(plus_token)
        node = UnaryOperator.new(operator, factor)
      elsif minus?
        operator = token
        consume(minus_token)
        node = UnaryOperator.new(operator, factor)
      elsif integer?
        consume(integer_token)
        node = Number.new(token)
      elsif left_parenthesis?
        consume(left_parenthesis_token)
        node = expr
        consume(right_parenthesis_token)
      end

      node
    end

    def consume(type)
      # verify the type of @token and advance @token to next_token
      unless type == @token.type
        message = "Expecting '#{send("#{type}_token", :value)}', " \
                  "got #{@token.inspect}."
        raise(ParserError, message)
      end

      @token = @lexer.next_token
    end
  end
end
