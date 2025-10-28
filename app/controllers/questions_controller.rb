class QuestionsController < ApplicationController
  def index
    @categories = Category.all
    
    # Ransackの検索オブジェクトを作成
    @q = Question.ransack(params[:q])
    
    # 検索結果を取得し、N+1問題を防ぐためにincludes(:category)を追加
    # distinct: true は検索結果の重複を防ぐ
    @questions = @q.result(distinct: true).includes(:category)
  end

  def show
    @question = Question.find(params[:id])
    @correct_answer_choice = @question.answer_choices.find_by(is_correct: true)

    # --- 閲覧履歴の保存 ---
    if user_signed_in?
      current_user.viewed_histories.find_or_create_by(question: @question)
    else
      session[:viewed_question_ids] ||= []
      session[:viewed_question_ids].unshift(@question.id)
      session[:viewed_question_ids].uniq!
      session[:viewed_question_ids] = session[:viewed_question_ids].take(10)
    end
    # ---------------------------------
  end

  def audio
    question = Question.find(params[:id])
    audio_file_path = TextToSpeechService.call(question.answer_en)
    send_file audio_file_path, type: "audio/mpeg", disposition: "inline"
  end

  # オートコンプリート検索用アクション
  def autocomplete
    @questions = Question.search_by_keyword(params[:keyword]).limit(10) # 上位10件に制限
    json_data = @questions.map do |question|
      { id: question.id, title_en: question.title_en, title_jp: question.title_jp }
    end

    # 強力なキャッシュ無効化ヘッダー
    expires_now
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    response.headers.delete("Etag")

    render json: json_data
  end
end
