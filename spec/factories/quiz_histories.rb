FactoryBot.define do
  factory :quiz_history do
    association :user
    association :category
    total_questions { 10 }
    correct_answers { Faker::Number.between(from: 0, to: 10) }
    score { (correct_answers.to_f / total_questions.to_f * 100).round }
  end
end
