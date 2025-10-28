class MypagesController < ApplicationController
  def show
    if user_signed_in?
      @quiz_histories = current_user.quiz_histories.order(created_at: :desc)
      @favorite_questions = current_user.favorite_questions.order('favorites.created_at DESC')
    else
      # ゲストユーザーの場合、セッションからお気に入りの質問IDを取得
      if session[:favorite_question_ids].present?
        @favorite_questions = Question.where(id: session[:favorite_question_ids])
        # セッションのID順に並び替え
        @favorite_questions = @favorite_questions.sort_by { |q| session[:favorite_question_ids].index(q.id) }
      else
        @favorite_questions = []
      end
      # ゲストユーザーにはクイズ履歴はないので空の配列をセット
      @quiz_histories = []
    end
  end
end
