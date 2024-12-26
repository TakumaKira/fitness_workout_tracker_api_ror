FactoryBot.define do
  factory :exercise do
    sequence(:name) { |n| "Exercise #{n}" }
    description { "Exercise description" }
    user
  end
end
