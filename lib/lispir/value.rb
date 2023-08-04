module Lispir
  module Value
    require 'lispir/value/abstract'
    require 'lispir/value/list'
    require 'lispir/value/lambda'

    BUILTINS = [
      '+',
      'begin',
      'define',
      'eq',
      'if',
      'let',
      'lambda'
    ]

    class Atom < Abstract
      def evaluate(env = {})
        return @source if BUILTINS.include?(@source)

        raise "Unbound variable '#{source}'" unless env.key?(@source)
        env[@source]
      end
    end

    class Number < Abstract; end
  end
end
