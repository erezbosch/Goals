FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password "password"

    factory :user_two do
      username "test2"
    end
  end
end
