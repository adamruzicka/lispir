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

  def self.evaluate_body(body, env = {})
    tokens = Tokenizer.tokenize(body)
    ast = AST.new(tokens)
    Value::List.new([Value::Atom.new('begin')] + ast.ast).evaluate(env)
  end
end
