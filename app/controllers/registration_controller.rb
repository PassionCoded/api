class RegistrationController < ApplicationController
  def register_user
    @user = User.create(user_params)

    if @user.save
      render json: payload(@user)
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def payload(user)
    return nil unless user and user.id

    {
      auth_token: JsonWebToken.encode({ user_id: user.id }),
      user: { 
        id: user.id, 
        email: user.email,
        profile: false,
        passions: []
      }
    }
  end
end
