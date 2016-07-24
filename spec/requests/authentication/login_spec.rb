require 'rails_helper'

RSpec.describe "authentication API", :type => :request do
  before(:each) do
    create(:user)
  end

  it "returns a correctly formatted JWT with valid email/password" do
    user = User.first

    email = user.email
    password = "password"

    post "/auth_user", { email: email, password: password }

    test_token = JsonWebToken.encode({ user_id: user.id })

    expect(response_as_json[:auth_token]).to eq(test_token)
  end
end
