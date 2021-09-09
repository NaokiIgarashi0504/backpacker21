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
      fill_in 'article_season', with: "1112-11-11"
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

RSpec.describe '記事編集', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end
  def basic_auth(path)
    name = ENV["BASIC_USER"]
    password = ENV["BASIC_PASSWORD"]
    visit "http://#{name}:#{password}@#{Capybara.current_session.server.host}:# {Capybara.current_session.server.port}#{path}"
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # article1を投稿したユーザーでログインする
      basic_auth root_path
      visit new_user_session_path
      fill_in 'Email', with: @article1.user.email
      fill_in 'Password', with: @article1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 詳細ページに移動する
      visit article_path(@article1)
      # article1に編集のボタンがあることを確認する
      expect(page).to have_link 'Edit', href: edit_article_path(@article1)
      # 編集ページへ遷移する
      visit edit_article_path(@article1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # expect(
      #   find('#article_country').value
      # ).to eq(@article1.country)
      # expect(
      #   find('#article_city').value
      # ).to eq(@article1.city)
      # # expect(
      # #   find('#article_season').value
      # # ).to eq(@article1.season)
      # expect(
      #   find('#article_english_id').value
      # ).to eq(@article1.english.id)
      # expect(
      #   find('#article_safe_id').value
      # ).to eq(@article1.safe.id)
      # expect(
      #   find('#article_nice_id').value
      # ).to eq(@article1.nice.id)
      # expect(
      #   find('#article_content').value
      # ).to eq(@article1.content)
      # 投稿内容を編集する
      fill_in 'article_country', with: "test"
      fill_in 'article_city', with: "test"
      fill_in 'article_season', with: "1111-11-11"
      select 'No', from: 'article[english_id]'
      select '★★', from: 'article[safe_id]'
      select '★★', from: 'article[nice_id]'
      fill_in 'article_content', with: "a"
      # 編集してもArticleモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Article.count }.by(0)
      # 詳細ページに移動する
      visit article_path(@article1)
      # トップページには先ほど変更した内容の記事が存在することを確認する（テキスト）
      expect(page).to have_content("test")
      expect(page).to have_content("test")
      expect(page).to have_content("★★")
      expect(page).to have_content("★★")
      expect(page).to have_content("1111-11-11")
      expect(page).to have_content("No")
      expect(page).to have_content("a")
    end
  end

  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したarticleの編集画面には遷移できない' do
      # article1を投稿したユーザーでログインする
      basic_auth root_path
      visit new_user_session_path
      fill_in 'Email', with: @article1.user.email
      fill_in 'Password', with: @article1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 詳細ページに移動する
      visit article_path(@article2)
      # article2に編集のボタンがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_article_path(@article2)
    end
    it 'ログインしていないとarticleの編集画面には遷移できない' do
      # トップページにいる
      basic_auth root_path
      visit root_path
      # article1の詳細ページに移動する
      visit article_path(@article1)
      # article1に編集のボタンがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_article_path(@article1)
      # article2の詳細ページに移動する
      visit article_path(@article2)
      # article2に編集のボタンがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_article_path(@article2)
    end
  end
end