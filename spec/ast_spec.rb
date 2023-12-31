module Lispir
  RSpec.describe AST do
    it "converts numbers" do
      ast = AST.new(['12', '1000']).ast
      values = [12, 1000].map { |i| Value::Number.new(i) }
      expected = Value::List.new(values)
      expect(ast).to eq(expected)
    end

    it 'converts atoms' do
      values = %w(hello ast)
      ast = AST.new(values).ast
      atoms = values.map { |s| Value::Atom.new(s) }
      expected = Value::List.new(atoms)
      expect(ast).to eq(expected)
    end

    it 'converts lists' do
      ast = AST.new(%w( ( ) ( ( ) ) ( ( ( ) ) ) )).ast
      expected = [
        Value::List.new([]),
        Value::List.new([Value::List.new([])]),
        Value::List.new([Value::List.new([Value::List.new([])])])
      ]
      expect(ast).to eq(Value::List.new(expected))
    end

    it 'converts programs' do
      program = <<~EOF
        (define inc (lambda (x) (+ x 1)))
      EOF

      tokens = Tokenizer.tokenize(program)
      ast = AST.new(tokens).ast

      expected = [
        Value::List.new(
          [
            Value::Atom.new('define'),
            Value::Atom.new('inc'),
            Value::List.new(
              [ Value::Atom.new('lambda'),
                Value::List.new([Value::Atom.new('x')]),
                Value::List.new(
                  [ Value::Atom.new('+'),
                    Value::Atom.new('x'),
                    Value::Number.new(1)
                  ])
              ])
          ])
      ]

      expect(ast).to eq(Value::List.new(expected))
    end
  end
end
