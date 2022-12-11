FactoryBot.define do
  # everydayrails 60ページ参照
  factory :user do
    name  { "Example User" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
