class MypagesController < ApplicationController
  def show
    if user_signed_in?
      load_user_data
    else
      load_guest_data
    end
  end

  private

  def load_user_data
    @quiz_histories = current_user.quiz_histories.order(created_at: :desc)
                                  .page(params[:quiz_history_page]).per(5)
    @favorite_questions = current_user.favorite_questions.order('favorites.created_at DESC')
                                      .page(params[:favorite_question_page]).per(5)
  end

  def load_guest_data
    # ゲストユーザーの場合、セッションからお気に入りの質問IDを取得
    favorite_ids = session[:favorite_question_ids] || []
    favorites = if favorite_ids.present?
                  Question.where(id: favorite_ids)
                          .sort_by { |q| favorite_ids.index(q.id) }
                else
                  []
                end
    @favorite_questions = Kaminari.paginate_array(favorites)
                                  .page(params[:favorite_question_page]).per(5)

    # ゲストユーザーにはクイズ履歴はないので空のページネーションオブジェクトをセット
    @quiz_histories = Kaminari.paginate_array([])
                              .page(params[:quiz_history_page]).per(5)
  end
end
