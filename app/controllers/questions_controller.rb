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
  end

  def audio
    question = Question.find(params[:id])
    audio_file_path = TextToSpeechService.call(question.answer_en)
    send_file audio_file_path, type: "audio/mpeg", disposition: "inline"
  end
end
