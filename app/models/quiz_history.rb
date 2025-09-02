class QuizHistory < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :quiz_results, dependent: :destroy
end
