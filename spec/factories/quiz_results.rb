FactoryBot.define do
  factory :quiz_result do
    association :quiz_history
    association :question
    association :selected_answer_choice, factory: :answer_choice
    is_correct { false }
  end
end
