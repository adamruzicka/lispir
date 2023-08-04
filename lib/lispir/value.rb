module Lispir
  module Value
    require 'lispir/value/abstract'
    require 'lispir/value/list'

    BUILTINS = [
      '+',
      'begin'
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
