# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  # ランディングページには認証は不要
  def home
    # app/views/pages/home.html.erb をレンダリングします
  end

  def terms; end

  def privacy; end
end
