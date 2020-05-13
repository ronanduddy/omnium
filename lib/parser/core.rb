# frozen_string_literal: true

module Parser
  # The parser will verify the format of a list of tokens (syntax analysis) by
  # 'recursive-descent'.
  class Core
    include AST

    PLUS = :plus
    MINUS = :minus
    MULTIPLY = :multiply
    DIVIDE = :divide
    INTEGER = :integer
    LEFT_PARENTHESIS = :left_parenthesis
    RIGHT_PARENTHESIS = :right_parenthesis
    EOF = :eof

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

      while @token.type == PLUS || @token.type == MINUS
        token = @token
        if @token.type == PLUS
          consume(PLUS)
        elsif @token.type == MINUS
          consume(MINUS)
        end

        node = BinaryOperator.new(node, token, term)
      end

      node
    end

    def term
      # term : factor ((MULTIPLY | DIVIDE) factor)*
      node = factor

      while @token.type == MULTIPLY || @token.type == DIVIDE
        token = @token
        if @token.type == MULTIPLY
          consume(MULTIPLY)
        elsif @token.type == DIVIDE
          consume(DIVIDE)
        end

        node = BinaryOperator.new(node, token, factor)
      end

      node
    end

    def factor
      # factor : (PLUS | MINUS) factor | INTEGER | LPAREN expr RPAREN
      token = @token
      node = nil # I don't think this should be nil; mirroring other methods for consistency. Should return early instead.

      if token.type == PLUS
        operator = token
        consume(PLUS)
        node = UnaryOperator.new(operator, factor)
      elsif token.type == MINUS
        operator = token
        consume(MINUS)
        node = UnaryOperator.new(operator, factor)
      elsif token.type == INTEGER
        consume(INTEGER)
        node = Number.new(token)
      elsif token.type == LEFT_PARENTHESIS
        consume(LEFT_PARENTHESIS)
        node = expr
        consume(RIGHT_PARENTHESIS)
      end

      node
    end

    def consume(type)
      # verify the type of @token and advance @token to next_token
      verify(type)
      @token = @lexer.next_token
    end

    def verify(type)
      case type
      when PLUS
        return if @token.type == PLUS
      when MINUS
        return if @token.type == MINUS
      when MULTIPLY
        return if @token.type == MULTIPLY
      when DIVIDE
        return if @token.type == DIVIDE
      when INTEGER
        return if @token.type == INTEGER
      when LEFT_PARENTHESIS
        return if @token.type == LEFT_PARENTHESIS
      when RIGHT_PARENTHESIS
        return if @token.type == RIGHT_PARENTHESIS
      when EOF
        return if @token.eof?
      else
        raise(ParserError, "Invalid token: #{@token.inspect}")
      end
    end
  end
end
