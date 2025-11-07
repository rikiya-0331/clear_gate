# ClearGate - 税関英語対策アプリ
<img width="500" src="https://i.gyazo.com/28e012e54e0e47425a8017da21f804b5.png"><br>
<br>

# 目次
- [サービス概要](#サービス概要)
- [サービスURL](#サービスurl)
- [サービス開発の背景](#サービス開発の背景)
- [機能紹介](#機能紹介)
- [技術構成について](#技術構成について)
  - [使用技術](#使用技術)
  - [ER図](#er図)
  - [画面遷移図](#画面遷移図)<br>
<br>

# サービス概要
〜 初めての海外旅行でも、もう怖くない。税関での英語の不安を解消する実践的学習アプリ 〜<br>
<br>

『ClearGate』は、初めて海外旅行に行く20代の若者や学生が、税関での英語対応に不安を感じることなく、自信を持ってコミュニケーションが取れるようになるための学習サービスです。<br>
<br>
クイズ形式で実践的な練習ができ、シンプルで使いやすいUI/UXで、ストレスなく学習を進めることができます。

<br>

# サービスURL
### https://cleargate.jp/<br>
<br>

# サービス開発の背景
私自身、海外旅行未経験者として、空港の税関での英語のやり取りに漠然とした不安を感じていました。「何を聞かれるかわからない」「うまく答えられなかったらどうしよう」という不安が、旅の楽しみを半減させてしまうことも。

友人たちからも「税関で焦った」「英語が聞き取れなかった」という実体験を聞くうちに、同じような不安を抱える人は多いと確信しました。

そこで、「**空港の税関でよく聞かれる質問を、クイズ形式で事前に学べるアプリ**」があれば、初めての海外旅行でも、もっと安心して、旅そのものを楽しめるようになるのではないか。

そんな思いから、私自身の不安を解消するために『ClearGate』を開発しました。

<br>

# 機能紹介

| アカウント作成 / ログイン |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/a99254e02b8e9f968fe6675f49b0ef3d.png)](https://gyazo.com/a99254e02b8e9f968fe6675f49b0ef3d)<br>
[![Image from Gyazo](https://i.gyazo.com/530fbec24510cf327ecf62757dc1bf58.png)](https://gyazo.com/530fbec24510cf327ecf62757dc1bf58) |
| <p align="left">メールアドレスとパスワードで簡単にユーザー登録ができます。登録後すぐにログインされ、サービスを利用開始できます。</p> |
<br>

| 質問一覧 / 詳細 |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/6f50f09f0119e785980b4057cc3a819c.png)](https://gyazo.com/6f50f09f0119e785980b4057cc3a819c)<br>
[![Image from Gyazo](https://i.gyazo.com/4e4a97a16bc52aabf2a4a4d5f8fe8b09.png)](https://gyazo.com/4e4a97a16bc52aabf2a4a4d5f8fe8b09) |
| <p align="left">税関でよく聞かれる質問をカテゴリ別、または一覧で確認できます。詳細ページでは、英文、その和訳をセットで学習できます。</p> |
<br>

| クイズ機能 |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/660e67eb345459c96a262b2d4fd3d4f3.png)](https://gyazo.com/660e67eb345459c96a262b2d4fd3d4f3)<br>
[![Image from Gyazo](https://i.gyazo.com/143caa6aa625d68e9fef1e9e0311841d.png)](https://gyazo.com/143caa6aa625d68e9fef1e9e0311841d)<br>
[![Image from Gyazo](https://i.gyazo.com/6cfec0f6d7cfb0e8835548934c1d6dc1.png)](https://gyazo.com/6cfec0f6d7cfb0e8835548934c1d6dc1)<br>
[![Image from Gyazo](https://i.gyazo.com/bc7ee449ed53f74504da72d6dc2c7166.png)](https://gyazo.com/bc7ee449ed53f74504da72d6dc2c7166)<br>
[![Image from Gyazo](https://i.gyazo.com/9431663d553d477a1cbc9b36b75991d9.png)](https://gyazo.com/9431663d553d477a1cbc9b36b75991d9) |
| <p align="left">実践的なクイズ形式で、学習内容の定着度を確認できます。クイズに回答すると、ボタン一つで解説の表示・非表示を切り替えることができ、自分のペースで学習を進められます。</p> |
<br>

| クイズ履歴 |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/5ac099161941a965e18167e8258ab889.png)](https://gyazo.com/5ac099161941a965e18167e8258ab889) |
| <p align="left">過去に挑戦したクイズの履歴を確認できます。実施日時、カテゴリ、正解数などが記録され、自分の学習の進捗を可視化できます。</p> |
<br>

| お気に入り機能 |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/74095131088ef6566c19e26173837e9a.png)](https://gyazo.com/74095131088ef6566c19e26173837e9a) |
| <p align="left">特に覚えておきたい質問や、苦手な質問をお気に入りに登録できます。マイページからいつでも見返すことができ、効率的な復習が可能です。</p> |
<br>

# 技術構成について

## 使用技術
| カテゴリ | 技術内容 |
| --- | --- |
| サーバーサイド | Ruby on Rails 7.1.3, Ruby 3.2.2 |
| フロントエンド | JavaScript, Stimulus |
| CSSフレームワーク | Tailwind CSS |
| データベース | PostgreSQL |
| 検索 | Ransack |
| 認証 | Devise |
| 管理画面 | ActiveAdmin|
| 音声合成 | Google Cloud Text-to-Speech API |
| デプロイ | Render |
| バージョン管理 | Git, GitHub |
<br>

## ER図
```mermaid
erDiagram
    USERS ||--o{ FAVORITES : "お気に入り登録"
    USERS ||--o{ QUIZ_HISTORIES : "クイズ履歴"
    USERS ||--o{ VIEWED_HISTORIES : "閲覧履歴"
    CATEGORIES ||--o{ QUESTIONS : "所属質問"
    CATEGORIES ||--o{ QUIZ_HISTORIES : "クイズカテゴリ"
    QUESTIONS ||--o{ ANSWER_CHOICES : "解答選択肢"
    QUESTIONS ||--o{ FAVORITES : "お気に入り対象"
    QUESTIONS ||--o{ QUIZ_RESULTS : "クイズ結果"
    QUESTIONS ||--o{ VIEWED_HISTORIES : "閲覧対象"
    QUIZ_HISTORIES ||--o{ QUIZ_RESULTS : "詳細結果"
    ANSWER_CHOICES ||--o{ QUIZ_RESULTS : "選択された回答"

    USERS {
        uuid id PK "ID"
        string email "メールアドレス"
        string encrypted_password "暗号化されたパスワード"
        string name "名前"
        string provider "プロバイダー"
        string uid "UID"
        string reset_password_token "パスワードリセットトークン"
        datetime reset_password_sent_at "パスワードリセット送信日時"
        datetime remember_created_at "ログイン記憶日時"
        integer sign_in_count "サインイン回数"
        datetime current_sign_in_at "現在のサインイン日時"
        datetime last_sign_in_at "最終サインイン日時"
        string current_sign_in_ip "現在のサインインIP"
        string last_sign_in_ip "最終サインインIP"
        datetime created_at
        datetime updated_at
    }

    CATEGORIES {
        uuid id PK "ID"
        string name "カテゴリ名"
        datetime created_at
        datetime updated_at
    }

    QUESTIONS {
        uuid id PK "ID"
        text title_jp "質問タイトル日本語"
        text title_en "質問タイトル英語"
        text answer_jp "質問和訳"
        text answer_en "質問英語"
        uuid category_id FK "カテゴリID"
        datetime created_at
        datetime updated_at
    }

    ANSWER_CHOICES {
        uuid id PK "ID"
        text content_jp "選択肢内容日本語"
        text content_en "選択肢内容英語"
        boolean is_correct "正解フラグ"
        uuid question_id FK "質問ID"
        datetime created_at
        datetime updated_at
    }

    FAVORITES {
        uuid id PK "ID"
        uuid user_id FK "ユーザーID"
        uuid question_id FK "質問ID"
        datetime created_at
        datetime updated_at
    }

    QUIZ_HISTORIES {
        uuid id PK "ID"
        integer score "スコア"
        integer total_questions "総問題数"
        integer correct_answers "正解数"
        uuid category_id FK "カテゴリID"
        uuid user_id FK "ユーザーID"
        datetime created_at
        datetime updated_at
    }

    QUIZ_RESULTS {
        uuid id PK "ID"
        boolean is_correct "解答が正解だったか"
        uuid selected_answer_choice_id FK "選択された解答選択肢ID"
        uuid quiz_history_id FK "クイズ履歴ID"
        uuid question_id FK "質問ID"
        datetime created_at
        datetime updated_at
    }

    VIEWED_HISTORIES {
        uuid id PK "ID"
        uuid user_id FK "ユーザーID"
        uuid question_id FK "質問ID"
        datetime created_at
        datetime updated_at
    }
``````
<br>

## 画面遷移図
https://www.figma.com/design/lB2xtaGdEbdXdZbgvTkG29/Clear-Gate%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=57-312&t=nVP7BJXdwYnuL6ib-1
