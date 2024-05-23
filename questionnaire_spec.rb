require_relative 'questionnaire'

RSpec.describe "Questionnaire" do
  # Mock PStore
  let(:store) { double("PStore", transaction: nil) }
end