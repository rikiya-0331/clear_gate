class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @quiz_histories = current_user.quiz_histories.order(created_at: :desc)
    @favorite_questions = Question.joins(:favorites).where(favorites: { user_id: current_user.id }).group('questions.id').order('MAX(favorites.created_at) DESC')
  end
end
