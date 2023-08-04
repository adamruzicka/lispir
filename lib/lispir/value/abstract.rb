module Lispir
  module Value
    class Abstract
      attr_reader :source

      def initialize(source)
        @source = source
      end

      def evaluate(_)
        @source
      end

      def to_s
        evaluate.to_s
      end

      def ==(other)
        self.source == other.source
      end
    end
  end
end
