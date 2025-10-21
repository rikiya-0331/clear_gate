require "google/cloud/text_to_speech" # トップレベルのgemをrequire

class TextToSpeechService
  AUDIO_CACHE_DIR = Rails.root.join("tmp", "audio")

  def initialize(text)
    @text = text
    @file_path = AUDIO_CACHE_DIR.join("#{Digest::MD5.hexdigest(text)}.mp3")
  end

  def self.call(text)
    new(text).call
  end

  def call
    # キャッシュが存在すれば、そのパスを返す
    return @file_path if File.exist?(@file_path)

    # Render環境などでGOOGLE_APPLICATION_CREDENTIALS_JSONが直接設定されている場合に対応
    if ENV['GOOGLE_APPLICATION_CREDENTIALS_JSON'].present?
      temp_credentials_file = Rails.root.join("tmp", "google_credentials.json")
      File.write(temp_credentials_file, ENV['GOOGLE_APPLICATION_CREDENTIALS_JSON'])
      ENV['GOOGLE_APPLICATION_CREDENTIALS'] = temp_credentials_file.to_s
    end

    # APIを呼び出して音声データを生成
    client = Google::Cloud::TextToSpeech.text_to_speech # クライアント初期化を修正

    synthesis_input = { text: @text }
    voice = { language_code: "en-US", name: "en-US-Wavenet-D" }
    audio_config = { audio_encoding: :MP3 }

    response = client.synthesize_speech(
      input: synthesis_input,
      voice: voice,
      audio_config: audio_config
    )

    # ディレクトリがなければ作成
    FileUtils.mkdir_p(AUDIO_CACHE_DIR)

    # 音声データをファイルに保存
    File.open(@file_path, "wb") do |file|
      file.write(response.audio_content)
    end

    @file_path
  end
end
