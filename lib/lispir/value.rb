module Lispir
  module Value
    require 'lispir/value/abstract'
    require 'lispir/value/list'

    class Atom < Abstract; end
    class Number < Abstract; end
  end
end
