class HistoriesController < ApplicationController
  def index
    if user_signed_in?
      @viewed_questions = current_user.viewed_questions.order('viewed_histories.created_at DESC')
    elsif session[:viewed_question_ids].present?
      # DBからIDに基づいて質問を取得
      @viewed_questions = Question.where(id: session[:viewed_question_ids])
      
      # セッションに保存されたIDの順序を維持して並び替え
      @viewed_questions = @viewed_questions.sort_by { |q| session[:viewed_question_ids].index(q.id) }
    else
      @viewed_questions = []
    end
  end
end
