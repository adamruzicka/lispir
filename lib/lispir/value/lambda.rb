module Lispir
  module Value
    class Lambda < Abstract
      attr_reader :env, :body, :bindings
      def initialize(body_forms, local_env, bindings)
        @env = local_env
        @bindings = bindings
        @body = if body_forms.length > 1
                  Value::List.new([Value::Atom.new('begin')] + body_forms)
                else
                  body_forms.first
                end
      end

      def evaluate(args, env = {})
        local_env = env.merge(@env)
        @bindings.source.zip(args).each do |k, v|
          local_env[k.source] = v.evaluate(env)
        end
        @body.evaluate(local_env)
      end
    end
  end
end
