require 'rails_helper'

RSpec.describe "passion api", :type => :request do
  describe "creating passions" do
    before(:each) do
      create(:user_with_profile)
    end

    it "returns correctly formatted response with new passions info with POST to /passions" do
      user = User.first

      token = user_token(user)

      post_to_passions(token)
      
      expect(response_as_json[:user][:passions][0][:name]).to eq("TestOne")
    end

    it "saves the passions to the database after POST to /passions" do
      user = User.first

      token = user_token(user)

      post_to_passions(token)

      expect(Passion.where(user: user)[0].name).to eq("TestOne")
    end

    it "creates multiple passions at once with POST to /passions" do
      user = User.first

      token = user_token(user)

      passions = {
        "passions": [
          {"name": "One"},
          {"name": "Two"},
          {"name": "Three"},
      }

      post_to_passions(token, passions)

      expect(response_as_json[:user][:passions][0][:name]).to eq("One")
      expect(response_as_json[:user][:passions][1][:name]).to eq("Two")
      expect(response_as_json[:user][:passions][2][:name]).to eq("Three")
    end
  end
end
