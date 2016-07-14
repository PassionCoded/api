require 'rails_helper'

RSpec.describe "profile api", :type => :request do
  describe "creating a profile" do
    before(:each) do
      create(:user)
    end


    it "returns user and profile info with POST to /profile" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash)

      expect(response_as_json[:user][:profile]).to eq(profile_hash)
    end

    it "saves profile to database with POST to /profile" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash)

      profile = Profile.find_by(user_id: response_as_json[:user][:id])

      expect(parse_profile(profile)).to eq(response_as_json[:user][:profile])
    end

    it "returns an error with invalid POST to /profile - no first name" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:first_name))

      expect(response_as_json[:errors][0]).to eq("One or more profile fields is missing or empty")

      confirm_profile_not_saved(user)
    end
    
    it "returns an error with invalid POST to /profile - no last name" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:last_name))

      expect(response_as_json[:errors][0]).to eq("One or more profile fields is missing or empty")

      confirm_profile_not_saved(user)
    end

    it "returns an error with invalid POST to /profile - no profession" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:profession))

      expect(response_as_json[:errors][0]).to eq("One or more profile fields is missing or empty")

      confirm_profile_not_saved(user)
    end

    it "returns an error with invalid POST to /profile - no tech of choice" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:tech_of_choice))

      expect(response_as_json[:errors][0]).to eq("One or more profile fields is missing or empty")

      confirm_profile_not_saved(user)
    end

    it "returns an error with invalid POST to /profile - no years experience" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:years_experience))

      expect(response_as_json[:errors][0]).to eq("One or more profile fields is missing or empty")

      confirm_profile_not_saved(user)
    end

    it "returns an error with invalid POST to /profile - no willing to manage" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:willing_to_manage))

      expect(response_as_json[:errors][0]).to eq("One or more profile fields is missing or empty")

      confirm_profile_not_saved(user)
    end

    it "returns an error with mismatched datatype POST to /profile - years experience not a number" do
      user = User.first

      token = user_token(user)

      post_to_profile(token, profile_hash(:years_experience, "foo"))

      expect(response_as_json[:errors][0]).to eq("Years experience is not a number")

      confirm_profile_not_saved(user)
    end
  end
end
