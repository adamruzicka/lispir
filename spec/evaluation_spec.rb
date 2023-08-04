module Lispir
  RSpec.describe "evaluation" do
    describe Value::Number do
      it 'evaluates to itself' do
        value = Lispir.evaluate_expression('1')
        expect(value).to eq(1)
      end
    end

    describe Value::Atom do
      it 'evaluates to itself for builtins' do
        Value::BUILTINS.each do |value|
          expect(value).to eq(value)
        end
      end

      it 'evaluates to a value from the environment' do
        value = Lispir.evaluate_expression('x', {'x' => 1})
        expect(value).to eq(1)
      end

      it 'raises an exception if unbound' do
        expect { Lispir.evaluate_expression('x') }.to raise_error(RuntimeError)
      end
    end

    describe '+' do
      it 'adds all its arguments' do
        value = Lispir.evaluate_expression('(+ 1 2 3)')
        expect(value).to eq(6)
      end
    end

    describe 'begin' do
      it 'evaluates all the expressions and returns the value of the last one' do
        value = Lispir.evaluate_expression('(begin 1 2 (+ 3 4))')
        expect(value).to eq(7)
      end
    end

    describe 'define' do
      it 'puts a value into the environment' do
        value = Lispir.evaluate_expression('(begin (define x (+ 3 4)) x)')
        expect(value).to eq(7)
      end
    end

    describe 'eq' do
      it 'compares two values' do
        value = Lispir.evaluate_expression('(eq 1 2)')
        expect(value).to eq(false)

        value = Lispir.evaluate_expression('(eq 1 1)')
        expect(value).to eq(true)
      end
    end

    describe 'if' do
      it 'evaluates the right branch' do
        value = Lispir.evaluate_expression('(if (eq 1 1) 5 6)')
        expect(value).to eq(5)

        value = Lispir.evaluate_expression('(if (eq 1 2) 5 6)')
        expect(value).to eq(6)
      end

      it 'does not evaluate the other branch' do
        value = Lispir.evaluate_expression('(if (eq 1 1) 5 unbound)')
        expect(value).to eq(5)

        value = Lispir.evaluate_expression('(if (eq 1 2) unbound 6)')
        expect(value).to eq(6)
      end
    end

    describe 'let' do
      it 'binds values in local environment' do
        value = Lispir.evaluate_expression('(let ((x (+ 3 4))) x)')
        expect(value).to eq(7)
      end

      it 'does not modify non-local environment' do
        exp = <<~EXP
          (begin
            (define x 3)
            (let ((x 1)) x)
            x)
        EXP
        value = Lispir.evaluate_expression(exp)
        expect(value).to eq(3)
      end
    end

    describe Value::Lambda do
      it 'gets to an intermediate representation' do
        env = {'foo' => 5}
        value = Lispir.evaluate_expression('(lambda (x) (+ x 1))', env)
        body = Value::List.new([
                                 Value::Atom.new('+'),
                                 Value::Atom.new('x'),
                                 Value::Number.new(1)
                               ])
        bindings = Value::List.new([Value::Atom.new('x')])
        expect(value).to eq(Value::Lambda.new(body, env, bindings))
      end

      it 'can be evaluated directly' do
        value = Lispir.evaluate_expression('((lambda (x) (+ x 1)) 1)')
        expect(value).to eq(2)
      end

      it 'can be bound with define and evaluated' do
        exp = <<~EXP
          (begin
            (define inc (lambda (x) (+ x 1)))
            (inc 1))
        EXP
        value = Lispir.evaluate_expression(exp)
        expect(value).to eq(2)
      end

      it 'can be recursive when bound' do
        exp = <<~EXP
          (begin
            (define upto
              (lambda (current target)
                (if (eq current target)
                    target
                    (upto (+ 1 current) target))))
            (upto 0 5))
        EXP

        value = Lispir.evaluate_expression(exp)
        expect(value).to eq(5)
      end
    end
  end
end
