FactoryBot.define do
  # everydayrails 60ページ参照
  factory :user do
    name  { "Example User" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end

FactoryBot.define do
  # factoryの名前をモデル名とは別にしたい場合は、以下のようにクラスを指定する
  factory :archer, class: "User" do
    name { "Sterling Archer" }
    sequence(:email) { |n| "test#{n}@example.gov" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
