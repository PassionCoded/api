FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email-#{n}@foo.com" }
    password              "password"
    password_confirmation "password"

    factory :user_with_profile do
      after(:create) do |user|
        Profile.create(
          user: user, 
          first_name: "Test_first_#{user.email}", 
          last_name: "Test_last_#{user.email}", 
          profession: "Web Developer - #{user.email}", 
          tech_of_choice: "JavaScript",
          years_experience: 1,
          willing_to_manage: false
        )
      end
    end
  end
end
