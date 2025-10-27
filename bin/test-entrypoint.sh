#!/bin/bash
set -e

# Gemのインストール
bundle check || bundle install

# データベースの準備
bundle exec rails db:prepare

# 引数で渡されたコマンドを実行
exec "$@"
