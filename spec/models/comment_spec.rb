require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  it 'commentカラムが空の場合コメントは保存できない' do
    @comment.comment = ''
    @comment.valid?
    expect(@comment.errors.full_messages).to include("Comment can't be blank")
  end

  it 'ユーザーが紐付いていないとコメントは保存できない' do
    @comment.user = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include('User must exist')
  end

  it '記事が紐付いていないとコメントは保存できない' do
    @comment.article = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include('Article must exist')
  end

end
