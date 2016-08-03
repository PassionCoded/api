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
      
      expect(response_as_json[:user][:passions][0][:name]).to eq("testone")
    end

    it "saves the passions to the database after POST to /passions" do
      user = User.first

      token = user_token(user)

      post_to_passions(token)

      expect(Passion.where(user: user)[0].name).to eq("testone")
    end

    it "creates multiple passions at once with POST to /passions" do
      user = User.first

      token = user_token(user)

      passions = {
        "passions": [
          {"name": "One"},
          {"name": "Two"},
          {"name": "Three"},
        ]
      }

      post_to_passions(token, passions)

      expect(response_as_json[:user][:passions][0][:name]).to eq("one")
      expect(response_as_json[:user][:passions][1][:name]).to eq("two")
      expect(response_as_json[:user][:passions][2][:name]).to eq("three")

      expect(Passion.where(user: user).length).to eq(3)
    end

    it "returns an error message with POST to /passions with invalid data - blank string" do
      user = User.first

      token = user_token(user)

      passions = {
        "passions": [
          {"name": "One"},
          {"name": ""}
        ]
      }

      post_to_passions(token, passions)

      expect(response_as_json[:errors][0]).to eq("Passions data formatted incorrectly or is blank")
      expect(Passion.where(user: user).length).to eq(0)
    end

    it "handles incorrectly formatted request - converts non-string data to strings (i.e. booleans, numbers)" do
      user = User.first

      token = user_token(user)

      passions = {
        "passions": [
          {"name": 1},
          {"name": true},
          {"name": false}
        ]
      }

      post_to_passions(token, passions)

      expect(response_as_json[:user][:passions][0][:name]).to eq("1")
      expect(response_as_json[:user][:passions][1][:name]).to eq("true")
      expect(response_as_json[:user][:passions][2][:name]).to eq("false")

      expect(Passion.where(user: user).length).to eq(3)
    end

    it "handles incorrectly formatted request - verifies the data sent is a passions array" do
      user = User.first

      token = user_token(user)

      passions = {
        "passions": {
          "name": "One"
        }
      }

      post_to_passions(token, passions)

      expect(response_as_json[:errors][0]).to eq("Passions must be an array of passion objects")
    end

    it "handles incorrectly formatted request - no passions object" do
      user = User.first

      token = user_token(user)

      incorrect_object = {
        "wrong": [
          "name": "Foo"
        ]
      }

      post_to_passions(token, incorrect_object)

      expect(response_as_json[:errors][0]).to eq("Passions must be an array of passion objects")
    end
  end
end
