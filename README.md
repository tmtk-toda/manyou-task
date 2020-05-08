"tasks"
  t.string   "name"
  t.text     "detail"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false


"users"
  t.string      "name"
  t.string      "email"
  t.string      "password_digest"
  t.datetime    "created_at", null: false
  t.datetime    "updated_at", null: false
  t.index       ["email"], name: "index_users_on_email", unique: true


  【デプロイ手順】
  
  ●ローカルでマスターブランチに移動
    $ git checkout master
  ●マスターブランチで開発中ブランチをマージする
    $ git merge 開発ブランチ名
  ●Herokuにログインする
    $ heroku login
  ●Herokuアプリ作成
    $ heroku create
  ●app/assetsディレクトリの中のファイルのうち、.jsと.cssファイル以外の全てのファイルをプリコンパイル
    $ rails assets:precompile RAILS_ENV=production
  ●ワーキング・ツリーの中で変更されたコンテンツ(新規、編集、削除したファイル)を見つけてインデックス(Git管理の対象)に追加
    $ git add -A
  ●開発環境でコンテンツの修正・追加・削除等を行い、ローカルリポジトリに変更履歴を記録
    $ git commit -m "任意のコメント"
  ●Herokuのアプリにローカルリポジトリにある変更履歴をアップロード
    $ git push heroku master
  ●Herokuのサーバ上にアプリケーションのテーブルを作成、マイグレーション実行
    $ heroku run rails db:migrate
  ●Herokuでアプリ確認
    $ heroku open 
