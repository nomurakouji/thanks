require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'Departmentモデル機能' do
    context 'すべての項目をn入力した場合' do
      it 'バリデーション通過' do
        expect(FactoryBot.build(:department)).to be_valid
      end
    end
    context 'nameにnilがある場合' do
        it 'バリデーションにかかる' do
          user = FactoryBot.build(:department,name: nil)
          user.valid?
        end    
      end
  end
end