class QuizHistory < ApplicationRecord
  belongs_to :category
  belongs_to :user, optional: true
  has_many :quiz_results, dependent: :destroy
end
