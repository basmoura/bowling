FactoryBot.define do
  factory :frame do
    first_pins_dropped { 1 }
    second_pins_dropped { 7 }
    strike { false }
    spare { false }
    status { 'live' }
    points { 0 }
    game
    user

    trait :strike do
      strike { true }
      first_pins_dropped { 10 }
      second_pins_dropped { 0 }
      points { 10 }
    end
  end
end
