require 'rails_helper'

RSpec.describe "passion api", :type => :request do
  describe "creating passions" do
    before(:each) do
      create(:user_with_profile)
    end

    def post_to_passions(token, data_array)
      post "/passions", data_array, {'Authorization': token}
    end

    it "returns user, profile and passions info with POST to /passions" do
      user = User.first

      token = user_token(user)

      # post_to_passions(token, [{"name": "Test One"}, {"name": "Test Two"}])
      passions = {
        "passions": [
          {"name": "TestOne"}
        ]
      }
      post "/passions", passions, {'Authorization': token}

      expect(response_as_json[:user][:passions][0][:name]).to eq("TestOne")
    end
  end
end
