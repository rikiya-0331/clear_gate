class ApplicationController < ActionController::Base
  before_action :_set_common_meta_tags
  helper_method :question_favorited?

  def after_sign_in_path_for(resource)
    questions_path # Change from root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  private

  def migrate_favorites_from_session(user)
    return if session[:favorite_question_ids].blank?

    # 現在ユーザーがすでにお気に入りにしている質問IDのリストを取得
    existing_favorite_ids = user.favorite_question_ids
    # セッション内のIDから、すでにDBに存在するものを除外
    new_favorite_ids = session[:favorite_question_ids] - existing_favorite_ids

    # 新しいお気に入りのみ一括で登録
    favorites_to_create = new_favorite_ids.map do |question_id|
      { user_id: user.id, question_id: question_id, created_at: Time.current, updated_at: Time.current }
    end

    Favorite.insert_all(favorites_to_create) if favorites_to_create.any?

    # セッションからお気に入り情報を削除
    session.delete(:favorite_question_ids)
  end

  def migrate_viewed_history_from_session(user)
    return if session[:viewed_question_ids].blank?

    existing_viewed_ids = user.viewed_question_ids
    new_viewed_ids = session[:viewed_question_ids] - existing_viewed_ids

    viewed_histories_to_create = new_viewed_ids.map do |question_id|
      { user_id: user.id, question_id: question_id, created_at: Time.current, updated_at: Time.current }
    end

    ViewedHistory.insert_all(viewed_histories_to_create) if viewed_histories_to_create.any?

    session.delete(:viewed_question_ids)
  end

  def question_favorited?(question)
    if user_signed_in?
      current_user.favorite_question_ids.include?(question.id)
    else
      session[:favorite_question_ids]&.include?(question.id)
    end
  end

  # meta-tags Gemのヘルパーとメソッド名が衝突しないようにアンダースコアを付与
  def _set_common_meta_tags
    site_name = "ClearGate"
    default_title = "ClearGate - 海外旅行の税関英語対策アプリ"
    description = "初めての海外旅行でも安心！ClearGateは、税関での英語対応に不安を感じる20代の若者向けに、よくある質問をクイズ形式で学べるアプリです。自信を持って税関を通過しましょう。"
    keywords = "税関英語, 海外旅行, 英語学習, クイズ, 空港英語, 初めての海外旅行, 20代, 英語不安解消"
    ogp_image = view_context.image_url("ogp.png") # view_context.image_url を使用

    set_meta_tags(
      site: site_name,
      title: default_title,
      description: description,
      keywords: keywords,
      og: {
        site_name: site_name,
        title: default_title,
        description: description,
        type: "website",
        url: request.original_url,
        image: ogp_image # 変数を使用
      },
      twitter: {
        card: "summary_large_image",
        site: "@ynYo87UW6s10979", # あなたのTwitterアカウント名 (任意)
        title: default_title,
        description: description,
        image: ogp_image # 変数を使用
      }
    )
  end
end
