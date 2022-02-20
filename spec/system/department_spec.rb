require 'rails_helper'

RSpec.describe 'department管理機能', type: :system do
  describe 'departmentのCRUD機能' do
    before do
        department = FactoryBot.create(:department)
        user = FactoryBot.create(:user, department:department)
        visit user_session_path
        click_on 'ゲスト管理者ログイン'
        test_link = find(:xpath,'/html/body/div[2]/div/div/div/a[3]/button')
        test_link.click
    end
    context 'departmentの作成' do
      it '新規部門名が表示される' do
        click_on '部門作成'
        fill_in 'department[name]', with:'開発部'
        click_on '作成する'
        expect(page). to have_content '開発部'
      end
    end
    context 'department閲覧' do
        it '新規部門名が表示される' do
          click_on '部門作成'
          fill_in 'department[name]', with:'開発部'
          click_on '作成する'
          expect(page). to have_content '開発部'
        end
    end
    context 'department編集' do
        it '新規部門名が表示される' do
          click_on '部門作成'
          fill_in 'department[name]', with:'開発部'
          click_on '作成する'
          expect(page). to have_content '開発部'
          test_link = find(:xpath,'/html/body/div[3]/div/table/tbody/tr[2]/td[3]/a')
          test_link.click
          fill_in 'department[name]', with:'ITシステム部'
          click_on '更新する'
          expect(page). to have_content 'ITシステム部'
        end
    end
    context 'department編集' do
        it '新規部門名が表示される' do
          click_on '部門作成'
          fill_in 'department[name]', with:'開発部'
          click_on '作成する'
          test_link = find(:xpath,'/html/body/div[3]/div/table/tbody/tr[2]/td[4]/form/input[2]')
          test_link.click 
          # アラートボタンを押す
          page.driver.browser.switch_to.alert.accept
          # 読み込み処理
          sleep(2)                
          # DB内に一致するレコードないかを確認
          expect(User.where(name: '開発部').count).to eq 0
        end
    end
  end
end