class User < ApplicationRecord
  has_many :quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_questions, through: :favorites, source: :question

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Replaced :validatable module with manual validations
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :email, uniqueness: { case_sensitive: false, message: "は正しくありません" }
  validates :password, presence: true, length: { in: 6..128 }, confirmation: true
end
