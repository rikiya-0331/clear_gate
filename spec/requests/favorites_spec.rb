require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:question) { create(:question, category: category) }

  before do
    sign_in user
  end

  describe "POST /questions/:question_id/favorites" do
    it "creates a new favorite" do
      expect {
        post question_favorites_path(question)
      }.to change(Favorite, :count).by(1)
      expect(response).to redirect_to(questions_path)
    end
  end

  describe "DELETE /questions/:question_id/favorites" do
    let!(:favorite) { create(:favorite, user: user, question: question) }

    it "destroys the favorite" do
      expect {
        delete question_favorites_path(question)
      }.to change(Favorite, :count).by(-1)
      expect(response).to redirect_to(questions_path)
    end
  end
end
