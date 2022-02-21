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
          user = FactoryBot.build(:post,comment: nil)
          user.valid?
        end    
    end
    context 'receiver_idにnilがある場合' do
        it 'バリデーションにかかる' do
          user = FactoryBot.build(:post,receiver_id: nil)
          user.valid?
        end    
    end
    context 'user_idにnilがある場合' do
        it 'バリデーションにかかる' do
          user = FactoryBot.build(:post,user_id: nil)
          user.valid?
        end    
      end
  end
end