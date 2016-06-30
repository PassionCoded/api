require 'rails_helper'

RSpec.describe "users api", :type => :request do
  describe "creating a user" do
    def post_to_reg(email, password, password_confirmation)
      post "/reg_user", {user: {email: "#{email}", password: "#{password}", password_confirmation: "#{password_confirmation}"}}
    end

    def confirm_user_not_saved(email)
      expect(User.find_by(email: email)).to be_nil
    end

    it "returns user instance with POST to /reg_user" do
      post_to_reg("test@example.com", "password", "password")

      expect(response).to be_success
      expect(response_as_json[:user][:email]).to eq("test@example.com")
    end

    it "saves user instance to database with POST to /reg_user" do
      post_to_reg("test@example.com", "password", "password")

      user = User.find(response_as_json[:user][:id])

      expect(user.email).to eq(response_as_json[:user][:email])
    end

    it "returns an error with invalid email POST to /reg_user" do
      post_to_reg("test", "password", "password")

      expect(response_as_json[:errors][0]).to eq("Email is invalid")

      confirm_user_not_saved("test")
    end
    
    it "returns an error with mismatched passwords POST to /reg_user" do
      post_to_reg("test@example.com", "password", "")

      expect(response_as_json[:errors][0]).to eq("Password confirmation doesn't match Password")

      confirm_user_not_saved("test@example.com")
    end

    it "returns an error with too short password on POST to /reg_user" do
      post_to_reg("test@example.com", "short", "short")

      expect(response_as_json[:errors][0]).to eq("Password is too short (minimum is 6 characters)")

      confirm_user_not_saved("test@example.com")
    end
  end
end
