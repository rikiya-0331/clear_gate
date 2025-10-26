FactoryBot.define do
  factory :question do
    title_jp { Faker::Lorem.sentence }
    title_en { Faker::Lorem.sentence }
    answer_jp { Faker::Lorem.paragraph }
    answer_en { Faker::Lorem.paragraph }
    association :category # Category Factoryと関連付ける
  end
end
