require 'rails_helper'

RSpec.describe 'Post管理機能', type: :system do
  describe 'postのCRUD機能' do
    before do
        department = FactoryBot.create(:department)
        user = FactoryBot.create(:user, department:department)
        user = FactoryBot.create(:second_user, department:department)
        visit user_session_path
        click_on 'ゲスト管理者ログイン'
        test_link = find(:xpath,'/html/body/div[2]/div/div/div/a[1]/button')
        test_link.click
    end
    context 'postの作成' do
        it '新規投稿が表示される' do
          click_on '投稿する'
          select '北河玲子', from: 'post[receiver_id]'
          fill_in 'post[comment]', with:'ありがとう'
          test_link = find(:xpath,' /html/body/div[2]/div/div/div/form/div[4]/button')
          test_link.click
          expect(page). to have_content 'ありがとう'
        end
      end
      context 'postの閲覧' do
        it '新規投稿が表示される' do
          click_on '投稿する'
          select '北河玲子', from: 'post[receiver_id]'
          fill_in 'post[comment]', with:'ありがとう'
          test_link = find(:xpath,' /html/body/div[2]/div/div/div/form/div[4]/button')
          test_link.click
          expect(page). to have_content 'ありがとう'
        end
      end
      context 'post編集' do
        it 'postが編集される' do
          click_on '投稿する'
          select '北河玲子', from: 'post[receiver_id]'
          fill_in 'post[comment]', with:'ありがとう'
          test_link = find(:xpath,' /html/body/div[2]/div/div/div/form/div[4]/button')
          test_link.click
          click_on'編集'
          fill_in 'post[comment]', with:'どうもです'
          test_link = find(:xpath,' /html/body/div[2]/div/div/div/form/div[4]/button')
          test_link.click
          expect(page). to have_content 'どうもです'
        end
    end
    context 'post削除' do
        it '投稿が削除される' do
            click_on '投稿する'
            select '北河玲子', from: 'post[receiver_id]'
            fill_in 'post[comment]', with:'ありがとう'
            test_link = find(:xpath,' /html/body/div[2]/div/div/div/form/div[4]/button')
            test_link.click
            click_on '戻る'
            test_link = find(:xpath,'//*[@id="slick-slide00"]/p/a[1]/img')
            test_link.click
            click_on '削除'
            # アラートボタンを押す
            page.driver.browser.switch_to.alert.accept
            # 読み込み処理
            sleep(2)                
            # DB内に一致するレコードないかを確認
            expect(Post.where(comment: 'ありがとう').count).to eq 0
        end
    end
  end
end

