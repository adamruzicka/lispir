module Lispir
  module Value
    class List < Abstract
      def evaluate(env = {})
        head, *rest = @source
        head = head.evaluate(env)

        case head
        when '+'
          rest.map { |arg| arg.evaluate(env) }.reduce(:+)
        when 'begin'
          ret = nil
          rest.each do |expr|
            ret = expr.evaluate(env)
          end
          ret
        when 'define'
          key, value = rest
          env[key.source] = value.evaluate(env)
        else
          raise "Cannot apply '#{head}'"
        end
      end
    end
  end
end
