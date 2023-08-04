module Lispir
  module Value
    class List < Abstract
      def evaluate
        head, *rest = @source
        head = head.evaluate

        case head
        when '+'
          rest.map(&:evaluate).reduce(:+)
        else
          raise "Cannot apply '#{head}'"
        end
      end
    end
  end
end
