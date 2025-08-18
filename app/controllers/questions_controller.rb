class QuestionsController < ApplicationController
  def index
    @categories = Category.all
    @questions = Question.all.includes(:category)
  end

  def show
    @question = Question.find(params[:id])
    @correct_answer_choice = @question.answer_choices.find_by(is_correct: true)
  end
end
