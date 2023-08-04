require "lispir/version"

module Lispir
  require 'lispir/tokenizer'
  require 'lispir/value'
  require 'lispir/ast'
  class Error < StandardError; end
  # Your code goes here...

  def self.evaluate_expression(expression, env = {})
    tokens = Tokenizer.tokenize(expression)
    ast = AST.new(tokens)
    ast.ast.first.evaluate(env)
  end
end
