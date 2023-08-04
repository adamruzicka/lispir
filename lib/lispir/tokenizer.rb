module Lispir
  class Tokenizer
    def self.tokenize(text)
      tokens = []
      current = nil
      text.chars.each do |char|
        case char
        when ' ', "\n"
          tokens << current unless current.nil?
          current = nil
        when '('
          tokens << current unless current.nil?
          tokens << '('
          current = nil
        when ')'
          tokens << current unless current.nil?
          tokens << ')'
          current = nil
        else
          current ||= ''
          current += char
        end
      end
      tokens << current if current
      tokens
    end
  end
end
