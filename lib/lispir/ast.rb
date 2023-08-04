module Lispir
  class AST
    attr_reader :ast
    def initialize(tokens)
      @ast = to_ast(tokens)
    end

    private

    def to_ast(tokens)
      stack = []
      ast = []
      tokens.each do |token|
        case token
        when '('
          stack << ast
          ast = []
        when ')'
          completed = ast
          ast = stack.pop
          ast << Lispir::Value::List.new(completed)
        else
          if token =~ /^-?\d+$/
            ast << Lispir::Value::Number.new(token.to_i)
          else
            ast << Lispir::Value::Atom.new(token)
          end
        end
      end

      Value::List.new ast
    end
  end
end
