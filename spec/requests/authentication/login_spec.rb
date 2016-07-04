require 'rails_helper'

RSpec.describe "authentication API", :type => :request do
  before(:each) do
    create(:user)
  end

  it "returns a correctly formatted JWT with valid email/password" do
  end
end
