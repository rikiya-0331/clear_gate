class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @favorite = current_user.favorites.build(question: @question)
    if @favorite.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @question, notice: 'お気に入りに登録しました。' }
      end
    else
      redirect_to @question, alert: 'お気に入りの登録に失敗しました。'
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(question: @question)
    if @favorite&.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @question, notice: 'お気に入りを解除しました。' }
      end
    else
      redirect_to @question, alert: 'お気に入りの解除に失敗しました。'
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end