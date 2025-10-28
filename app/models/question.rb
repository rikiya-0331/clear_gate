class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :viewed_histories, dependent: :destroy
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
    %w[category quiz_results favorites favoring_users]
  end

  def correct_answer
    answer_choices.find_by(is_correct: true)
  end

  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  # 英文タイトルで部分一致検索を行うスコープ
  scope :search_by_keyword, ->(keyword) {
    where("title_en ILIKE ? OR title_jp ILIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
  }

  # テスト環境ではID順、それ以外ではランダム順で問題を返すスコープ
  scope :in_random_order, -> { Rails.env.test? ? order(id: :asc) : order("RANDOM()") }
end