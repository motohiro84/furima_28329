FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {"a12345"}
    password_confirmation {password}
    first_name            {Gimei.name.first.kanji}
    last_name             {Gimei.name.last.kanji}
    first_name_reading    {Gimei.name.first.katakana}
    last_name_reading     {Gimei.name.last.katakana}
    birthday              {Faker::Date.birthday}
  end
end