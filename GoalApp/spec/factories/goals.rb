FactoryGirl.define do
  factory :goal do
    body { Faker::Lorem.word }
    goal_type true

    factory :private_goal do
      goal_type false
    end
  end
end
