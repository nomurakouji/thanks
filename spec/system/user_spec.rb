require 'rails_helper'

RSpec.describe 'ユーザー管理機能' , type: :system do
    describe 'ログイン機能' do 
      context 'ゲスト管理者がログインした場合' do
        it 'ゲスト管理者が表示される' do
            department = FactoryBot.create(:department)
            user = FactoryBot.create(:user, department:department)
            visit user_session_path
            click_on 'ゲスト管理者ログイン'
            expect(page). to have_content 'ログイン中:ゲスト管理者'
        end
      end
      context 'ゲストユーザーがログインした場合' do
        it 'ゲストユーザーが表示される' do
            department = FactoryBot.create(:department)
            user = FactoryBot.create(:third_user, department:department)
            visit user_session_path
            click_on 'ゲストログイン'
            expect(page). to have_content 'ログイン中:ゲストユーザー'
        end
      end
      context '一般のユーザーがログインした場合' do
        it 'ユーザー名が表示される' do
            department = FactoryBot.create(:department)
            user = FactoryBot.create(:second_user, department:department)
            visit user_session_path
            fill_in 'メールアドレス', with:'kitakawa@reiko.com'
            fill_in 'パスワード', with:'password'
            click_on 'ログイン'
            expect(page). to have_content 'ログイン中:北河玲子'
        end
      end
    end
    describe 'ユーザーCRUD機能' do
        context 'ユーザー新規作成' do
          it '新規ユーザー名が表示される' do
            department = FactoryBot.create(:department)
            user = FactoryBot.create(:user, department:department)
            second_department = FactoryBot.create(:second_department)
            user = FactoryBot.create(:second_user, department:second_department)
            visit user_session_path
            click_on 'ゲスト管理者ログイン'
            # ユーザー管理ボタンをクリック
            find(:xpath,'/html/body/div[2]/div/div/div/a[2]/button').click
            click_on 'ユーザー作成'
            # セレクトから部門名前を入力
            find("#user_department_id").find("option[value='2']").select_option
            fill_in 'user[name]', with:'rihana'
            fill_in 'user[email]', with:'rihana@rihana.com'
            attach_file 'user[image]', "#{Rails.root}/spec/fixtures/pexels-pixabay-415829.jpg"
            fill_in 'user[password]', with:'password'
            fill_in 'user[password_confirmation]', with:'password'
            click_on '登録する'
            expect(page). to have_content 'rihana'
          end
        end
        context 'ユーザー編集機能' do
            it 'ユーザーを編集できる' do    
                department = FactoryBot.create(:department)
                second_department = FactoryBot.create(:second_department)
                user = FactoryBot.create(:user, department:department)
                second_user = FactoryBot.create(:second_user, department:second_department)
                visit user_session_path
                click_on 'ゲスト管理者ログイン'
                # ユーザー管理ボタンをクリック
                find(:xpath,'/html/body/div[2]/div/div/div/a[2]/button').click
                click_on "ユーザーID"
                # 編集ボタンをクリック
                find(:xpath,'/html/body/div[3]/div/table/tbody[2]/tr[2]/td[5]/a').click
                # 読み込み時間
                sleep(2)
                fill_in 'user[name]', with:'南川礼子'
                click_on '編集する'
                expect(page). to have_content '南川礼子'
            end
        end
        context 'ユーザー閲覧機能' do
            it 'ユーザーを閲覧できる' do    
                department = FactoryBot.create(:department)
                second_department = FactoryBot.create(:second_department)
                user = FactoryBot.create(:user, department:department)
                second_user = FactoryBot.create(:second_user, department:second_department)
                visit user_session_path
                click_on 'ゲスト管理者ログイン'
                # ユーザー管理をクリック
                test_link = find(:xpath,'/html/body/div[2]/div/div/div/a[2]/button')
                test_link.click
                expect(page). to have_content '北河玲子'
            end
        end
        context 'ユーザー削除機能' do
            it 'ユーザーを削除できる' do    
              department = FactoryBot.create(:department)
              second_department = FactoryBot.create(:second_department)
              user = FactoryBot.create(:user, department:department)
              second_user = FactoryBot.create(:second_user, department:second_department)
                visit user_session_path
                click_on 'ゲスト管理者ログイン'
                # ユーザー管理をクリック
                find(:xpath,'/html/body/div[2]/div/div/div/a[2]/button').click 
                click_on "ユーザーID"
                # 削除ボタンをクリック”
                find(:xpath,'/html/body/div[3]/div/table/tbody[2]/tr[2]/td[6]/form/input[2]').click
                # アラートボタンを押す
                page.driver.browser.switch_to.alert.accept
                # 読み込み処理
                # DB内に一致するレコードないかを確認
                sleep(2)
                expect(User.where(name: '北河玲子').count).to eq 0
            end
        end
    end
    describe 'アクセス制限に関するテスト' do
      context 'ユーザーの編集機能' do
        it '他人の情報を編集できない' do    
          department = FactoryBot.create(:department)
            second_department = FactoryBot.create(:second_department)
            user = FactoryBot.create(:user, department:department)
            second_user = FactoryBot.create(:second_user, department:second_department)
            visit user_session_path
            fill_in 'メールアドレス', with:'kitakawa@reiko.com'
            fill_in 'パスワード', with:'password'
            click_on 'ログイン'
            click_on 'ユーザー一覧'
            expect(page.all('編集').count).not_to eq 2
        end
      end
    end 
end