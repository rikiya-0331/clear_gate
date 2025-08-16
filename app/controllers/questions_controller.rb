class QuestionsController < ApplicationController
  def index
    @categories = Category.all
    @questions = Question.all.includes(:category)
  end
end
