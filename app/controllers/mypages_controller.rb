class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @quiz_histories = current_user.quiz_histories.order(created_at: :desc)
    @favorite_questions = current_user.favorite_questions.joins(:favorites).order('favorites.created_at DESC')
  end
end
