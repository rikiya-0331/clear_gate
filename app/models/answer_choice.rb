class AnswerChoice < ApplicationRecord
  belongs_to :question

  def self.ransackable_attributes(auth_object = nil)
    ["content_en", "content_jp", "created_at", "id", "is_correct", "question_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["question"]
  end
end
