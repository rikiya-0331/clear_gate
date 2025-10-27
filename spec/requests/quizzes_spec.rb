# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  let!(:category) { create(:category) }
  let(:user) { create(:user) }

  describe 'GET /quizzes' do
    before do
      sign_in user
    end

    it 'responds successfully' do
      get quizzes_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /quiz/start' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'responds successfully' do
      get start_quizzes_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /quizzes/:id/detail' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    let!(:question) { create(:question, category: category) }

    it 'responds successfully' do
      get detail_quiz_path(question)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /quiz/start' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, category: category) }

    before do
      sign_in user
    end

    it 'creates a new quiz history and redirects to the first question' do
      expect do
        post start_quizzes_path, params: { category_id: category.id }
      end.to change(QuizHistory, :count).by(1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(quiz_path(Question.find(session[:quiz_question_ids].first)))
    end
  end

  describe 'GET /quiz/:id' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, category: category) }

    context 'when quiz has been started' do
      before do
        sign_in user
        post start_quizzes_path, params: { category_id: category.id }
      end

      it 'responds successfully' do
        get quiz_path(question)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when quiz has not been started' do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it 'redirects to the root path' do
        get quiz_path(question)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST /quiz/:id/answer' do
    let!(:question1) { create(:question, category: category, created_at: 2.hours.ago) }
    let!(:question2) { create(:question, category: category, created_at: 1.hour.ago) }
    let!(:correct_answer) { create(:answer_choice, question: question1, is_correct: true) }
    let!(:incorrect_answer) { create(:answer_choice, question: question1, is_correct: false) }

    before do
      sign_in user
    end

    context 'with a correct answer' do
      it 'returns a correct response and URL for the next question' do
        quiz_history = create(:quiz_history, user: user, category: category)
        allow_any_instance_of(QuizzesController).to receive(:session).and_return({
                                                                                   quiz_question_ids: [question1.id, question2.id],
                                                                                   quiz_history_id: quiz_history.id
                                                                                 })
        post answer_quiz_path(question1), params: { choice_id: correct_answer.id }
        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body
        expect(json_response['correct']).to be true
        expect(json_response['next_question_url']).to eq quiz_path(question2)
        expect(QuizResult.count).to eq 1
        expect(QuizResult.last.is_correct).to be true
      end
    end

    context 'with an incorrect answer' do
      it 'returns an incorrect response and URL for the next question' do
        quiz_history = create(:quiz_history, user: user, category: category)
        allow_any_instance_of(QuizzesController).to receive(:session).and_return({
                                                                                   quiz_question_ids: [question1.id, question2.id],
                                                                                   quiz_history_id: quiz_history.id
                                                                                 })
        post answer_quiz_path(question1), params: { choice_id: incorrect_answer.id }
        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body
        expect(json_response['correct']).to be false
        expect(json_response['next_question_url']).to eq quiz_path(question2)
        expect(QuizResult.count).to eq 1
        expect(QuizResult.last.is_correct).to be false
      end
    end

    context 'with the last question' do
      it 'returns a response with the results URL' do
        quiz_history = create(:quiz_history, user: user, category: category)
        allow_any_instance_of(QuizzesController).to receive(:session).and_return({
                                                                                   quiz_question_ids: [question1.id],
                                                                                   quiz_history_id: quiz_history.id
                                                                                 })
        post answer_quiz_path(question1), params: { choice_id: correct_answer.id }
        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body
        expect(json_response['correct']).to be true
        expect(json_response['next_question_url']).to be_nil
        expect(json_response['results_url']).to eq results_quizzes_path
      end
    end
  end

  describe 'GET /quiz/results' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, category: category) }
    let!(:answer_choice) { create(:answer_choice, question: question, is_correct: true) }

    context 'when quiz is finished' do
      before do
        sign_in user
        post start_quizzes_path, params: { category_id: category.id }
        post answer_quiz_path(question), params: { choice_id: answer_choice.id }
      end

      it 'responds successfully' do
        get results_quizzes_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when quiz is not started' do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it 'redirects to the root path' do
        get results_quizzes_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
