require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @user = FactoryBot.create(:user)
    visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_button "commit"
    task1 = FactoryBot.create(:task, user_id: @user.id)
    task2 = FactoryBot.create(:second_task, user_id: @user.id)
    task3 = FactoryBot.create(:task, name: '付け加えた名前１', user_id: @user.id)
    task4 = FactoryBot.create(:task, name: '付け加えた名前２', user_id: @user.id)
    task5 = FactoryBot.create(:second_task, name: '付け加えた名前３', detail: '付け加えたコンテント', user_id: @user.id)
    label = FactoryBot.create(:label)
    task_label = FactoryBot.create(:task_label, task_id: task1.id)
    # FactoryBot.create.(:lavel,user_id: @user.id)
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
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
      end
    end
    context 'labelの検索をした場合' do
      it 'らべるの絞り込み検索ができる' do
        visit tasks_path
        fill_in 'label', with: "sample"
        click_on 'Search'
        save_and_open_page
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
      context 'name、completed、labelの全て検索をした場合' do
        it '全ての絞り込み検索ができる' do
          visit tasks_path
          fill_in 'Search_name', with: 'Factoryで作ったデフォルトのタイトル１'
          select '未着手', from: 'Completed'
          fill_in 'label', with: "sample"
          click_on 'Search'
          save_and_open_page
          expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        end
      end
  end
end   



  