# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz_data, only: [:show, :answer]

  def index; end

  def start
    @categories = Category.all
  end

  def create
    category = Category.find(params[:category_id])
    questions = category.questions.order(:id).all.sample(10)

    if questions.empty?
      redirect_to root_path, alert: "このカテゴリには問題がありません。"
      return
    end

    @quiz_history = QuizHistory.create!(
      user: current_user,
      category: category,
      total_questions: questions.count,
      correct_answers: 0
    )
    session[:quiz_question_ids] = questions.pluck(:id)
    session[:quiz_history_id] = @quiz_history.id

    redirect_to quiz_path(questions.first.id)
  end

  def show
    @question = Question.find(params[:id])
    @answer_choices = @question.answer_choices.shuffle

    current_index = @question_ids.index(@question.id)
    @current_question_number = current_index + 1
    @next_question_id = @question_ids[current_index + 1]
  end

  def answer
    quiz_history = QuizHistory.find(session[:quiz_history_id])
    question = Question.find(params[:id])
    selected_answer_choice = AnswerChoice.find(params[:choice_id])
    is_correct = selected_answer_choice.is_correct

    if is_correct
      quiz_history.increment!(:correct_answers)
      quiz_history.increment!(:score, 10)
    end

    QuizResult.create!(
      quiz_history: quiz_history,
      question: question,
      selected_answer_choice: selected_answer_choice,
      is_correct: is_correct
    )

    current_question_index = @question_ids.index(question.id)
    next_question_id = @question_ids[current_question_index + 1]

    correct_answer_choice = question.answer_choices.find_by(is_correct: true)
    correct_answer_id = correct_answer_choice.id if correct_answer_choice

    response_data = {
      correct: is_correct,
      correct_answer_id: correct_answer_id,
      question_answer_jp: question.answer_jp # 正解の日本語訳を追加
    }

    if next_question_id
      response_data[:next_question_url] = quiz_path(next_question_id)
    else
      quiz_history.update!(score: (quiz_history.correct_answers.to_f / quiz_history.total_questions.to_f * 100).round)
      response_data[:results_url] = results_quizzes_path
    end

    render json: response_data
  end

  def detail
    @question = Question.find(params[:id])
  end

  def results
    @quiz_history = QuizHistory.find_by(id: session[:quiz_history_id])
    if @quiz_history.nil?
      redirect_to root_path, alert: 'クイズの履歴が見つかりません。'
      return
    end
    @quiz_results = @quiz_history.quiz_results.includes(:question, :selected_answer_choice)
    session.delete(:quiz_history_id)
    session.delete(:quiz_question_ids)
  end

  private

  def set_quiz_data
    @question_ids = session[:quiz_question_ids]
    @quiz_history = QuizHistory.find_by(id: session[:quiz_history_id])

    if @question_ids.blank? || @quiz_history.blank?
      redirect_to root_path, alert: "クイズセッションが見つかりません。もう一度最初からやり直してください。"
      throw :abort
    end

    @total_questions = @question_ids.count
  end
end
