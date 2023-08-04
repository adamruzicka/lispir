RSpec.describe Lispir::Tokenizer do
  it "correctly tokenizes strings" do
    tokens = Lispir::Tokenizer.tokenize('(+ 1 2 (+ 3 4))')
    expected = %w(( + 1 2 ( + 3 4 ) ))
    expect(tokens).to eq(expected)
  end

  it "correctly tokenizes files" do
    expected = %w(( + 1 2 ( + 5 6 ) ))
    file = File.join(__dir__, 'test.lisp')
    File.open(file) do |f|
      expect(Lispir::Tokenizer.tokenize(f)).to eq(expected)
    end
  end
end
