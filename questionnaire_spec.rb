require_relative 'questionnaire'

RSpec.describe "Questionnaire" do
  # Mock PStore
  let(:store) { double("PStore") }

  describe "#do_prompt" do 
    it "prompts user to answer each question" do
      allow_any_instance_of(Object).to receive(:gets).and_return("Yes\n", "No\n", "Yes\n", "No\n", "Yes\n") # Stub user input
      expect(STDOUT).to receive(:puts).with("Can you code in Ruby? (Yes/No): ").once # Expect prompt for Ruby question
      expect(STDOUT).to receive(:puts).with("Can you code in JavaScript? (Yes/No): ").once # Expect prompt for JavaScript question
      expect(STDOUT).to receive(:puts).with("Can you code in Swift? (Yes/No): ").once # Expect prompt for Swift question
      expect(STDOUT).to receive(:puts).with("Can you code in Java? (Yes/No): ").once # Expect prompt for Java question
      expect(STDOUT).to receive(:puts).with("Can you code in C#? (Yes/No): ").once # Expect prompt for C# question
      answers = do_prompt # Execute method under test
      expect(answers).to eq({"q1" => true, "q2" => false, "q3" => true, "q4" => false, "q5" => true})
    end
  end
end