FactoryBot.define do
  factory :answer_choice do
    content_jp { Faker::Lorem.sentence }
    content_en { Faker::Lorem.sentence }
    is_correct { false }
    association :question # Question Factoryと関連付ける

    trait :correct do
      is_correct { true }
    end
  end
end
