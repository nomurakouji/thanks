require 'rails_helper'

RSpec.describe 'Post管理機能', type: :system do
  describe 'postのCRUD機能' do
    before do
        department = FactoryBot.create(:department)
        user = FactoryBot.create(:user, department:department)
        user = FactoryBot.create(:second_user, department:department)
        visit user_session_path
        click_on 'ゲスト管理者ログイン'
    end
    context 'postの作成' do
        it '新規投稿が表示される' do
          click_on '投稿'
          select '北河玲子', from: 'post[receiver_id]'
          fill_in 'post[comment]', with:'ありがとう'
          click_on '投稿する'
          expect(page). to have_content 'ありがとう'
        end
      end
      context 'postの閲覧' do
        it '新規投稿が表示される' do
          click_on '投稿'
          select '北河玲子', from: 'post[receiver_id]'
          fill_in 'post[comment]', with:'ありがとう'
          click_on '投稿する'
          expect(page). to have_content 'ありがとう'
        end
      end
      context 'post編集' do
        it 'postが編集される' do
          click_on '投稿'
          select '北河玲子', from: 'post[receiver_id]'
          fill_in 'post[comment]', with:'ありがとう'
          click_on '投稿する'
          click_on'編集'
          fill_in 'post[comment]', with:'どうもです'
          click_on '投稿する'
          expect(page). to have_content 'どうもです'
        end
      end
    context 'post削除' do
        it '投稿が削除される' do
            click_on '投稿'
            select '北河玲子', from: 'post[receiver_id]'
            fill_in 'post[comment]', with:'ありがとう'
            click_on '投稿する'
            click_on 'TOP画面'
            test_link = find(:xpath,'//*[@id="slick-slide00"]/p/a[1]/img')
            test_link.click
            click_on '削除'
            # アラートボタンを押す
            page.driver.browser.switch_to.alert.accept
            # 読み込み処理
            sleep(1)
            # DB内に一致するレコードないかを確認
            expect(Post.where(comment: 'ありがとう').count).to eq 0
        end
    end
  end
    describe 'アクセス制限に関するテスト' do
      context '投稿ーの編集機能' do
        it '他人の投稿を編集できない' do    
            department = FactoryBot.create(:department)
            second_department = FactoryBot.create(:second_department)
            user = FactoryBot.create(:user, department:department)
            second_user = FactoryBot.create(:second_user, department:second_department)
            visit user_session_path
            click_on 'ゲスト管理者ログイン'
            # 投稿管理ボタンをクリック
            find(:xpath,'/html/body/div[2]/div/div/div/a[1]/button').click
            click_on '投稿'
            select '北河玲子', from: 'post[receiver_id]'
            fill_in 'post[comment]', with:'ありがとう'
            click_on '投稿する'
            click_on '戻る'
            click_on 'ログアウト'
            visit user_session_path
            fill_in 'メールアドレス', with:'kitakawa@reiko.com'
            fill_in 'パスワード', with:'password'
            click_on 'ログイン'
            # 画像をクリック
            test_link = find(:xpath,'//*[@id="slick-slide00"]/p/a[1]/img')
            test_link.click
            expect(page.all('編集').count).to eq 0
        end
      end
  end
end

