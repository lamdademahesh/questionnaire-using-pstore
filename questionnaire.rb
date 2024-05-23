require "pstore" # https://github.com/ruby/pstore

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

def do_prompt
  answers = {}
  QUESTIONS.each do |question_key, question|
    print "#{question} (Yes/No): "
    answer = gets.chomp.downcase
    answers[question_key] = answer == "yes" || answer == "y" ? true : false
  end
  answers
end

do_prompt