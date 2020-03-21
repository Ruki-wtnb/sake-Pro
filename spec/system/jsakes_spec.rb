require 'rails_helper'

describe '日本酒データ管理機能', type: :system do
 describe 'ログイン→マイページ表示' do
   let(:user_a) { FactoryBot.create(:user, name: 'テストユーザA', email: 'testA@test.com') } #ユーザAを作成しておく
   let!(:jsake_a) { FactoryBot.create(:jsake, user: user_a) } #日本酒Aを作成しておく
   let!(:favorite_a) { FactoryBot.create(:favorite, user: user_a, jsake: jsake_a) } #ユーザAが日本酒Aをいいねしている
  
  before do
   visit login_path
   fill_in 'メールアドレス', with: login_user.email
   fill_in 'パスワード', with: login_user.password
   click_button 'ログイン' #ユーザAでログインする
  end
  
  context 'ユーザAがログインしている時' do
    let(:login_user) { user_a }
   
   it 'マイページに_日本酒Aが表示される' do
    expect(page).to have_content '日本酒A'#日本酒Aのサムネイルができていることを確認
   end
   
   before 'トップページへ遷移したとき' do
    visit root_path
   end
   it 'マイページに_日本酒Aが表示される' do
    expect(page).to have_content '日本酒A'
   end
   
   before '「日本酒」で検索したとき' do
    fill_in 'key' , with: '日本酒'
     click_button '検索'
   end
   it '検索結果に日本酒Aが表示される' do
    expect(page).to have_content '日本酒A'
   end

   
  end
  
 end
end