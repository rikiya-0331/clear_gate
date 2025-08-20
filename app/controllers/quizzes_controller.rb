class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def start
    @categories = Category.all
  end

  def create
    category = Category.find(params[:category_id])
    questions = category.questions.all.sample(10)
    
    @quiz_history = QuizHistory.create(
      user: current_user,
      category: category,
      total_questions: questions.count,
      correct_answers: 0
    )
    session[:quiz_question_ids] = questions.pluck(:id)
    session[:quiz_history_id] = @quiz_history.id

    if questions.empty?
      redirect_to results_quizzes_path, alert: "このカテゴリには問題がありません。"
    else
      redirect_to quiz_path(questions.first.id)
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer_choices = @question.answer_choices.shuffle
    @quiz_history = QuizHistory.find_by(id: session[:quiz_history_id])
  end

  def answer
    question = Question.find(params[:id])
    selected_answer_choice = AnswerChoice.find(params[:answer_choice_id])
    quiz_history = QuizHistory.find(session[:quiz_history_id])

    is_correct = selected_answer_choice.is_correct?

    QuizResult.create!(
      quiz_history: quiz_history,
      question: question,
      selected_answer_choice: selected_answer_choice,
      is_correct: is_correct
    )

    if is_correct
      quiz_history.increment!(:correct_answers)
    end

    question_ids = session[:quiz_question_ids]
    current_question_index = question_ids.index(question.id)
    next_question_id = question_ids[current_question_index + 1]

    if next_question_id
      render json: { correct: is_correct, next_question_url: quiz_path(next_question_id) }
    else
      quiz_history.update(score: quiz_history.correct_answers) # scoreを更新
      render json: { correct: is_correct, results_url: results_quizzes_path }
    end
  end

  def results
    @quiz_history = QuizHistory.find_by(id: session[:quiz_history_id])
    @quiz_results = @quiz_history.quiz_results.includes(:question, :selected_answer_choice) if @quiz_history
    session.delete(:quiz_history_id)
    session.delete(:quiz_question_ids)
  end
end
