require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
    @image_path = Rails.root.join('public/images/furima-test-image.png')
  end
  def basic_auth(path)
    name = ENV["BASIC_USER"]
    password = ENV["BASIC_PASSWORD"]
    visit "http://#{name}:#{password}@#{Capybara.current_session.server.host}:# {Capybara.current_session.server.port}#{path}"
  end
  context '記事の投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_auth root_path
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('New Article')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      attach_file('article[images][]', @image_path, make_visible: true)
      fill_in 'article_country', with: @article.country
      fill_in 'article_city', with: @article.city
      fill_in 'article_season', with: @article.season
      select 'Yes', from: 'article[english_id]'
      select '★', from: 'article[safe_id]'
      select '★', from: 'article[nice_id]'
      fill_in 'article_content', with: @article.content
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Article.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容の画像と@article.countryと@article.nice.nameが存在することを確認する
      expect(page).to have_selector("img[src$='furima-test-image.png']")
      expect(page).to have_content(@article.country)
      expect(page).to have_content(@article.nice.name)
    end
  end
  context '記事の投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('New Article')
    end
  end
end
