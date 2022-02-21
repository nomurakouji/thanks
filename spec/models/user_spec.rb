require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Userモデル機能' do
    context 'すべての項目を入力した場合'do
      it "バリデーション通過" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end
    context 'nameにnilがある場合' do
      it 'バリデーションにかかる' do
        user = FactoryBot.build(:user,name: nil)
        user.valid?
      end    
    end
    context 'emailにnilがある場合' do
      it 'バリデーションにかかる' do
        user = FactoryBot.build(:user,email: nil)
        user.valid?
      end    
    end
    context 'imageにnilがある場合' do
      it 'バリデーションにかかる' do
        user = FactoryBot.build(:user,image: nil)
        user.valid?
      end    
    end
    context 'passwordにnilがある場合' do
      it 'バリデーションにかかる' do
        user = FactoryBot.build(:user,password: nil)
        user.valid?
      end    
    end
    context 'password_confirmationにnilがある場合' do
      it 'バリデーションにかかる' do
        user = FactoryBot.build(:user,password_confirmation: nil)
        user.valid?
      end    
    end
    context 'department_idにnilがある場合' do
      it 'バリデーションにかかる' do
        user = FactoryBot.build(:user,department_id: nil)
        user.valid?
      end    
    end
  end
end
