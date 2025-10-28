class FavoritesController < ApplicationController
  before_action :set_question

  def create
    if user_signed_in?
      @favorite = current_user.favorites.build(question: @question)
      @favorite.save
    else
      session[:favorite_question_ids] ||= []
      session[:favorite_question_ids] << @question.id
      session[:favorite_question_ids].uniq!
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to questions_path, notice: 'お気に入りに登録しました。' }
    end
  end

  def destroy
    if user_signed_in?
      @favorite = current_user.favorites.find_by(question: @question)
      @favorite&.destroy
    else
      session[:favorite_question_ids]&.delete(@question.id)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to questions_path, notice: 'お気に入りを解除しました。' }
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end