FactoryBot.define do
  factory :comment do
    comment_content { "MyText" }
    user { nil }
    article { nil }
  end
end
