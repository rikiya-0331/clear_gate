require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /questions" do
    it "responds successfully" do
      get questions_path
      expect(response).to have_http_status(:success)
    end
  end
end
