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
        when 'eq'
          a, b = rest.map { |expr| expr.evaluate(env) }
          a == b
        when 'if'
          condition, truthy, falsey = rest
          branch = condition.evaluate(env) ? truthy : falsey
          branch.evaluate(env)
        else
          raise "Cannot apply '#{head}'"
        end
      end
    end
  end
end
