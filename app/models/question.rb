class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
  has_many :favorites, dependent: :destroy
  accepts_nested_attributes_for :answer_choices, allow_destroy: true

  # Ransackでの検索・フィルタリングを制御
  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      # Active Admin管理画面で許可する属性 (フィルタで使用)
      %w[title_jp created_at category_id id]
    else
      # 公開画面の検索で許可する属性
      %w[title_jp title_en]
    end
  end

  def self.ransackable_associations(auth_object = nil)
    # 公開画面でも管理画面でも 'category' での絞り込みは共通で許可
    %w[category]
  end

  def correct_answer
    answer_choices.find_by(is_correct: true)
  end

  def favorited_by?(user)
    favorites.exists?(user: user)
  end
end