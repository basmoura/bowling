FactoryBot.define do
  factory :admin do
    name { 'David Gilmour'}
    sequence(:email) { |n| "d#{n}@floyd.com" }
    password { 'timemoneyusandthem' }
  end
end
