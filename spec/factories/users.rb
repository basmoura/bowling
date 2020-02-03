FactoryBot.define do
  factory :user do
    name { "David Gilmour" }
    sequence(:nickname) { |n| "Eclipse #{n}" }
  end
end
