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
  end
end
