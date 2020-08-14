FactoryBot.define do
  factory :product do
    title         {Faker::Lorem.paragraph_by_chars(number: 10 )}
    text          {Faker::Lorem.sentence}
    price         {Faker::Number.within(range: 300..9999999)}
    category_id   {Faker::Number.within(range: 2..48)}
    prefecture_id {Faker::Number.within(range: 2..11)}
    condition     {Faker::Number.within(range: 2..7)}
    postage       {Faker::Number.within(range: 2..3)}
    shipment      {Faker::Number.within(range: 2..4)}
    association :user 
  end
end
