class InfoController < ApplicationController
  before_filter :authenticate_request!
  
  def user_info
    @user = User.find(current_user.id)
    render json: payload(@user)
  end
end
