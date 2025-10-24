require 'rails_helper'

RSpec.describe "Mypages", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /mypage" do
    it "responds successfully" do
      get mypage_path
      expect(response).to have_http_status(:success)
    end
  end
end
