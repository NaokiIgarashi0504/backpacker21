require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  def basic_auth(path) # ここを追記
    name = ENV["BASIC_USER"]
    password = ENV["BASIC_PASSWORD"]
    visit "http://#{name}:#{password}@#{Capybara.current_session.server.host}:# {Capybara.current_session.server.port}#{path}"
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_auth root_path
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('SignUp')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('Logout')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('SignUp')
      expect(page).to have_no_content('Login')
    end
  end

end
