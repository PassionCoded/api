
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
      passion_to_delete = Passion.where(user: User.first)[0]

      delete "/passions/#{passion_to_delete.id}", nil, {'Authorization': user_token(User.first)}

      expect(response_as_json[:user][:passions][0][:name]).to eq("two")
    end

    it "deletes nothing with DELETE request to /passions with passion not in the user's passion" do
      all_passions = Passion.where(user: User.first)
      passion_ids = []

      all_passions.each do |p|
        passion_ids.push p.id
      end

      nonexistant_passion = passion_ids.inject(:+)

      delete "/passions/#{nonexistant_passion}", nil, {'Authorization': user_token(User.first)}

      expect(response_as_json[:user][:passions][0][:name]).to eq("one")
      expect(response_as_json[:user][:passions][1][:name]).to eq("two")
      expect(response_as_json[:user][:passions][2][:name]).to eq("three")
    end
  end
end
