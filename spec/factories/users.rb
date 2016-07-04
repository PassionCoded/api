FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email-#{n}@foo.com" }
    password              "password"
    password_confirmation "password"
  end
end
