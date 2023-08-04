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
  end
end
