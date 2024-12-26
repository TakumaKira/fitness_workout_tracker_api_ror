FactoryBot.define do
  factory :workout do
    name { "My Workout" }
    date { Date.current }
    user
  end
end
