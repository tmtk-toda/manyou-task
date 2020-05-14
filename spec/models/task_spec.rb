require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:task, name: '付け加えた名前１')
    FactoryBot.create(:task, name: '付け加えた名前２')
    FactoryBot.create(:second_task, name: '付け加えた名前３', detail: '付け加えたコンテント')
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
    it 'titleが空ならバリデーションが通らない' do
      task = Task.new(name: '', detail: '失敗テスト')
      expect(task).not_to be_valid
    end
    end
  end  
    it 'contentが空ならバリデーションが通らない' do
      # ここに内容を記載する
      task = Task.new(name: '失敗テスと', detail: '')
      expect(task).not_to be_valid
    end
    it 'nameとcontentに内容が記載されていればバリデーションが通る' do
      # ここに内容を記載する
      task = Task.new(name: '成功テスト', detail: '成功テスト')
      expect(task).to be_valid
    end
  end

  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(name: "task", detail: "sample_task")
      Task.create(name: "sample", detail: "sample_sample")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.get_by_taskname('task').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      # ここに内容を記載する
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      # ここに内容を記載する
    end
  end
   
