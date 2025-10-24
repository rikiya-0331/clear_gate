require 'rails_helper'

RSpec.describe "QuizHistories", type: :request do
  let(:user) { create(:user) }
  let(:quiz_history) { create(:quiz_history, user: user) }

  before do
    sign_in user
  end

  describe "GET /quiz_histories/:id" do
    it "responds successfully" do
      get quiz_history_path(quiz_history)
      expect(response).to have_http_status(:success)
    end
  end
end
