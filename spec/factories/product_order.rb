FactoryBot.define do
  factory :product_order do
    token         { "tok_samplesample" }
    postal_code   { "123-4567" }
    prefecture_id { 2 }
    city          { "大阪市" }
    house_number  { "1-1" }
    building_name { '大阪ハイツ' }
    phone         { "09012345678" }
  end
end