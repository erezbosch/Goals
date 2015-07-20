FactoryGirl.define do
  factory :user do
    username "test"
    password "password"

    factory :user_two do
      username "test2"
    end
  end
end
