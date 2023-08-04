module Lispir
  module Value
    require 'lispir/value/abstract'

    class Atom < Abstract; end
    class Number < Abstract; end
    class List < Abstract; end
  end
end
