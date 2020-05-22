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
      it '作成済みのタスクが表示される' do
        # beforeに必要なタスクデータが作成されるので、ここでテストデータ作成処理を書く必要がない
        visit tasks_path
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content '付け加えた名前３'
        expect(task_list[1]).to have_content '付け加えた名前２'
      end
    end
    context 'labelの全て検索をした場合' do
      it 'らべるの絞り込み検索ができる' do
        fill_in 'sample from Lavel
        click_on 'Search'
        expect(page).to have_content '付け加えた名前１','未着手','sample'
      end
    end
  end
  end
end   



  describe 'タスク一覧画面' do
    context 'name、completed、labelの全て検索をした場合' do
      it '全ての絞り込み検索ができる' do
        fill_in 'Search_name', with: '付け加えた名前１'
        select '未着手', from: 'Completed'
        fill_in 'sample from Lavel
        click_on 'Search'
        expect(page).to have_content '付け加えた名前１','未着手','sample'
      end
    end
  end