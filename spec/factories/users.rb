FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email-#{n}@foo.com" }
    password              "password"
    password_confirmation "password"

    factory :user_with_profile do

    end
  end

end
