FactoryBot.define do
 factory :jsake do
  image_url { 'test' }
  meigara { '日本酒A' }
  seimai_buai { '純米酒' }
  locaility { '東京都' }
  alcohol_degree { '15.0' }
  sake_meter_value { 1.0 }
  acidity { 1.0 }
  user
 end
end