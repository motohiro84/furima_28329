FactoryBot.define do
  factory :product do
    title         { '木の絵' }
    text          { '木が描かれた絵' }
    price         { 3000 }
    category_id   { 2 }
    prefecture_id { 2 }
    condition     { 2 }
    postage       { 2 }
    shipment      { 2 }
    association :user
  end
end
