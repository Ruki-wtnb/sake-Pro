FactoryBot.define do
 factory :user do
  name { 'テストユーザ' }
  email { 'test@test.com' }
  password { 'test1234' }
 end
end