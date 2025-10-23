class ApplicationController < ActionController::Base
  include ActionView::Helpers::AssetUrlHelper # この行を追加

  before_action :_set_common_meta_tags # この行を追加

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  private

  # meta-tags Gemのヘルパーとメソッド名が衝突しないようにアンダースコアを付与
  def _set_common_meta_tags
    site_name = "ClearGate"
    default_title = "ClearGate - 海外旅行の税関英語対策アプリ"
    description = "初めての海外旅行でも安心！ClearGateは、税関での英語対応に不安を感じる20代の若者向けに、よくある質問をクイズ形式で学べるアプリです。自信を持って税関を通過しましょう。"
    keywords = "税関英語, 海外旅行, 英語学習, クイズ, 空港英語, 初めての海外旅行, 20代, 英語不安解消"

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
        image: image_url("ogp.png") # app/assets/images/ogp.png を指定 (ファイル名は適宜変更)
      },
      twitter: {
        card: "summary_large_image",
        site: "@ynYo87UW6s10979", # あなたのTwitterアカウント名 (任意)
        title: default_title,
        description: description,
        image: image_url("ogp.png") # app/assets/images/ogp.png を指定 (ファイル名は適宜変更)
      }
    )
  end
end
