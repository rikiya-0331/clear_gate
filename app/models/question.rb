class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  accepts_nested_attributes_for :answer_choices, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title_jp category_id created_at id answer_en answer_jp title_en updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["answer_choices", "category", "favorites", "quiz_results", "users"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title_jp category_id]
  end
  has_many :quiz_results, dependent: :destroy
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :answer_choices

  def correct_answer
    answer_choices.find_by(is_correct: true)
  end

  def favorited_by?(user)
    favorites.exists?(user: user)
  end
end
