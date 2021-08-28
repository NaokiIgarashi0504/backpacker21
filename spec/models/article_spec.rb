require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe '#create' do
    context '記事が投稿できるとき'
    it '全ての項目の入力が存在すれば投稿できる' do
      expect(@article).to be_valid
    end
  end

  context '記事が投稿できないとき' do
    it 'countryがない場合は投稿できない' do
      @article.country = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("Country can't be blank")
    end

    it 'cityがない場合は投稿できない' do
      @article.city = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("City can't be blank")
    end

    it 'seasonがない場合は投稿できない' do
      @article.season = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("Season can't be blank")
    end

    it 'contentがない場合は投稿できない' do
      @article.content = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("Content can't be blank")
    end

    it 'safe_idがない場合は投稿できない' do
      @article.safe_id = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("Safe can't be blank")
    end

    it 'safe_idが1の場合は投稿できない' do
      @article.safe_id = 1
      @article.valid?
      expect(@article.errors.full_messages).to include("Safe can't be blank")
    end

    it 'nice_idがない場合は投稿できない' do
      @article.nice_id = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("Nice can't be blank")
    end

    it 'nice_idが1の場合は投稿できない' do
      @article.nice_id = 1
      @article.valid?
      expect(@article.errors.full_messages).to include("Nice can't be blank")
    end

    it 'english_idがない場合は投稿できない' do
      @article.english_id = ''
      @article.valid?
      expect(@article.errors.full_messages).to include("English can't be blank")
    end


    it 'english_idが1の場合は投稿できない' do
      @article.english_id = 1
      @article.valid?
      expect(@article.errors.full_messages).to include("English can't be blank")
    end

    it 'countryが半角英数字でない場合は投稿できない' do
      @article.country = 'てすと'
      @article.valid?
      expect(@article.errors.full_messages).to include('Country is invalid')
    end

    it 'cityが半角英数字でない場合は投稿できない' do
      @article.city = 'てすと'
      @article.valid?
      expect(@article.errors.full_messages).to include('City is invalid')
    end

    it 'seasonが規定の形でない場合は投稿できない' do
      @article.season = '1'
      @article.valid?
      expect(@article.errors.full_messages).to include('Season is invalid')
    end

    it 'user_idがない場合は登録できない' do
      @article.user = nil
      @article.valid?
      expect(@article.errors.full_messages).to include('User must exist')
    end
    it 'imagesがない場合は登録できない' do
      @article.images = nil
      @article.valid?
      expect(@article.errors.full_messages).to include("Images can't be blank")
    end
  end
end
