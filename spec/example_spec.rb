RSpec.describe Lispir do
  describe "examples" do
    it "upto.lisp" do
      File.open(File.join(__dir__, '..', 'examples', 'upto.lisp')) do |f|
        expected = <<~OUT
        0
        1
        2
        3
        4
        5
        OUT
        expect { Lispir.evaluate_body(f) }.to output(expected).to_stdout
      end
    end

    it "factorial.lisp" do
      File.open(File.join(__dir__, '..', 'examples', 'factorial.lisp')) do |f|
        expected = <<~OUT
        120
        OUT
        expect { Lispir.evaluate_body(f) }.to output(expected).to_stdout
      end
    end
  end
end
