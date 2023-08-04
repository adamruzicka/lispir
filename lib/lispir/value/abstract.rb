module Lispir
  module Value
    class Abstract
      attr_reader :source

      def initialize(source)
        @source = source
      end

      def evaluate
        @source
      end

      def to_s
        evaluate.to_s
      end
    end
  end
end
