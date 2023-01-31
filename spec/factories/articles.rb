FactoryBot.define do
  factory :orange, class: Article do
    title { "My orange" }
    content { "I just ate an orange!" }
    created_at { 10.minutes.ago }
  end

  factory :most_recent, class: Article do
    title { "a short Test" }
    content { "Writing a short test" }
    created_at { Time.zone.now }
    user { association :user, email: "recent@example.com" }
  end
end

def user_with_posts(posts_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:orange, posts_count, user: user)
  end
end

FactoryBot.define do
  factory :post_by_user, class: Article do
    title { "User" }
    content { "Posted by User" }
    created_at { Time.zone.now }
    user
  end

  factory :post_by_archer, class: Article do
    title { "Archer" }
    content { "Posted by Archer" }
    created_at { Time.zone.now }
    user factory: :archer
  end

  factory :post_by_lana, class: Article do
    title { "Lana" }
    content { "Posted by Lana" }
    created_at { Time.zone.now }
    user factory: :lana
  end
end
