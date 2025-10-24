require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    it 'is valid with a unique email and password' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'is invalid with a duplicate email (case-insensitive)' do
      create(:user, email: user.email.upcase) # 既存ユーザーを作成
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("は正しくありません")
    end

    it 'is invalid with an invalid email format' do
      user.email = 'invalid-email'
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end

  describe 'associations' do
    let(:user) { create(:user) } # アソシエーションテスト用にユーザーを作成

    it 'has many quiz histories' do
      expect(User.reflect_on_association(:quiz_histories).macro).to eq :has_many
    end

    it 'destroys associated quiz histories' do
      create(:quiz_history, user: user)
      expect { user.destroy }.to change(QuizHistory, :count).by(-1)
    end

    it 'has many favorites' do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end

    # Favorite Factoryはまだ作成していないので、dependent: :destroyのテストはスキップ
    # it 'destroys associated favorites' do
    #   create(:favorite, user: user)
    #   expect { user.destroy }.to change(Favorite, :count).by(-1)
    # end

    it 'has many favorite questions through favorites' do
      expect(User.reflect_on_association(:favorite_questions).macro).to eq :has_many
      expect(User.reflect_on_association(:favorite_questions).options[:through]).to eq :favorites
      expect(User.reflect_on_association(:favorite_questions).options[:source]).to eq :question
    end
  end
end
