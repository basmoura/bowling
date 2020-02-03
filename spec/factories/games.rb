FactoryBot.define do
  factory :game do
    start_at { "2020-02-03 15:09:30" }
    end_at { "2020-02-03 15:09:30" }
    status { 'live' }
    lane
  end
end
