require 'rails_helper'

RSpec.describe Chat, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Postモデル機能' do
    context 'messageにnilがある場合' do
        it 'バリデーションにかかる' do
          chat = FactoryBot.build(:chat,message: nil)
          chat.valid?
        end    
    end
    context 'messageが51文字以上ある場合' do
      it 'バリデーションにかかる' do
        chat = FactoryBot.build(:chat,message: "123456789012345678901234567890123456789012345678901234567890")
        chat.valid?
      end    
    end
  end
end
