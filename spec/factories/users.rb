FactoryBot.define do
  # everydayrails 60ページ参照
  factory :user do
    name  { "Example User" }
    email { "user@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
