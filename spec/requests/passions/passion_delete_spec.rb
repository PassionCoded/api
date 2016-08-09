
require 'rails_helper'

RSpec.describe "passion api", :type => :request do
  describe "delete passions" do
    before(:each) do
      create(:user_with_profile)

      passions = {
        "passions": [
          {"name": "one"},
          {"name": "two"},
          {"name": "three"},
        ]
      }

      post_to_passions(user_token(User.first), passions)
    end

    it "deletes correct passion with DELETE request to /passions" do
      passion_to_delete = {
        "passions": [
          { "name": "one" }
        ]
      }

      delete "/passions", passion_to_delete, {'Authorization': user_token(User.first)}

      expect(response_as_json[:user][:passions][0][:name]).to eq("two")
    end

    it "deletes multiple passions with DELETE request to /passions" do
      passions_to_delete = {
        "passions": [
          { "name": "one" },
          { "name": "two" }
        ]
      }

      delete "/passions", passions_to_delete, {'Authorization': user_token(User.first)}

      expect(response_as_json[:user][:passions][0][:name]).to eq("three")
    end

    it "deletes nothing with DELETE request to /passions with passion not in the user's passion" do
      passion_to_delete = {
        "passions": [
          { "name": "fake" }
        ]
      }

      delete "/passions", passion_to_delete, {'Authorization': user_token(User.first)}

      expect(response_as_json[:user][:passions][0][:name]).to eq("one")
      expect(response_as_json[:user][:passions][1][:name]).to eq("two")
      expect(response_as_json[:user][:passions][2][:name]).to eq("three")
    end
  end
end
