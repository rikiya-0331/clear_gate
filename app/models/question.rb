class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  has_many :quiz_results, dependent: :destroy

  accepts_nested_attributes_for :answer_choices

  def correct_answer
    answer_choices.find_by(is_correct: true)
  end
end
