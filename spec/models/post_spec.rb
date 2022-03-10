require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Postモデル機能' do
    context 'すべての項目を入力した場合' do
      it 'バリデーション通過' do
        expect(FactoryBot.build(:post)).to be_valid
      end
    end
    context 'commentにnilがある場合' do
        it 'バリデーションにかかる' do
          post = FactoryBot.build(:post,comment: nil)
          post.valid?
        end    
    end
    context 'commentが51文字以上ある場合' do
      it 'バリデーションにかかる' do
        post = FactoryBot.build(:post,comment: "123456789012345678901234567890123456789012345678901234567890")
        post.valid?
      end    
    end
    context 'receiver_idにnilがある場合' do
        it 'バリデーションにかかる' do
          post = FactoryBot.build(:post,receiver_id: nil)
          post.valid?
        end    
    end
    context 'user_idにnilがある場合' do
        it 'バリデーションにかかる' do
          post = FactoryBot.build(:post,user_id: nil)
          post.valid?
        end    
      end
  end
end