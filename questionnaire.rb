# Import pstore to persist the data
require "pstore" # https://github.com/ruby/pstore

# Constants
STORE_NAME = "tendable.pstore"

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# Method to prompt user for answer(s) to questions
def do_prompt
  answers = {}
  QUESTIONS.each do |question_key, question|
    puts "#{question} (Yes/No): "  # Prompt user for input
    answer = gets.chomp.downcase # Get input and convert to lowercase
    answers[question_key] = answer == "yes" || answer == "y" ? true : false # Store answers as true or false
  end
  answers
end

# Method to calculate and print the Rating
def do_report(answers)
  total_questions = QUESTIONS.size
  store = PStore.new(STORE_NAME)
  yes_total = answers.count{|_key, val| val } #Count the total number of 'Yes' answers
  current_rating = yes_total.to_f / total_questions * 100 # Calculate rating
  puts "Your Rating for this Run : #{current_rating.round(2)}"
  store.transaction do 
    store[:ratings] ||=[]
    store[:ratings] << current_rating
  end
  avg_rating = store.transaction{ (store[:ratings].sum.to_f / store[:ratings].size).round(2) } # Calculate average rating
  puts "Average Rating for all Run: #{avg_rating}%"
  current_rating
end

# Method to instantiate the Survey
def run_survey
  loop do
    p "Welcome to the Coding Survey !"
    answers = do_prompt
    do_report(answers)
    p "Do you want to run the survey again? (Yes/No) : "
    rerun = gets.chomp.downcase
    break unless rerun == 'yes' || rerun == 'y'
  end
end

run_survey