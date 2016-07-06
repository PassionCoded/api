FactoryGirl.define do
  factory :passion do
    sequence(:name) { |n| "Passion-#{n}" }
  end

end
