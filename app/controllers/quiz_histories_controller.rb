class QuizHistoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @quiz_history = current_user.quiz_histories.includes(quiz_results: [{ question: :answer_choices }, :selected_answer_choice]).find(params[:id])
  end
end
