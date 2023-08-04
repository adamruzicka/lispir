module Lispir
  module Value
    class List < Abstract
      def evaluate(env = {})
        head, *rest = @source
        head = head.evaluate(env)

        case head
        when '+'
          rest.map { |arg| arg.evaluate(env) }.reduce(:+)
        else
          raise "Cannot apply '#{head}'"
        end
      end
    end
  end
end
