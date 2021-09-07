require 'rails_helper'

RSpec.describe Reply, type: :model do
  before do
    @reply = FactoryBot.build(:reply)
  end

  it 'replyカラムが空の場合コメントは保存できない' do
    @reply.reply = ''
    @reply.valid?
    expect(@reply.errors.full_messages).to include("Reply can't be blank")
  end

  it 'ユーザーが紐付いていないとコメントは保存できない' do
    @reply.user = nil
    @reply.valid?
    expect(@reply.errors.full_messages).to include('User must exist')
  end

  it 'コメントが紐付いていないとコメントは保存できない' do
    @reply.comment = nil
    @reply.valid?
    expect(@reply.errors.full_messages).to include('Comment must exist')
  end
end
