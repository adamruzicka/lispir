require "lispir/version"

module Lispir
  require 'lispir/tokenizer'
  require 'lispir/value'
  require 'lispir/ast'
  class Error < StandardError; end
  # Your code goes here...

  def self.evaluate_expression(expression, env = {})
    tokens = Tokenizer.tokenize(expression)
    AST.new(tokens).ast.source.first.evaluate(env)
  end

  def self.evaluate_body(body, env = {})
    tokens = Tokenizer.tokenize(body)
    ast = AST.new(tokens)
    ast.ast.source.unshift(Value::Atom.new('begin'))
    ast.ast.evaluate(env)
  end
end
