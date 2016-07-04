class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])

    if user.valid_password?(params[:password])
      profile = Profile.find_by(user_id: user.id)
      render json: payload(user, profile)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  private

  def payload(user, profile)
    return nil unless user and user.id

    if profile
      {
        auth_token: JsonWebToken.encode({ user_id: user.id }),
        user: { 
          id: user.id, 
          email: user.email,
          profile: {
            first_name: profile.first_name,
            last_name: profile.last_name,
            profession: profile.profession,
            tech_of_choice: profile.tech_of_choice,
            years_experience: profile.years_experience,
            willing_to_manage: profile.willing_to_manage
          },
          passions: []
        }
      }
    else
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
end
