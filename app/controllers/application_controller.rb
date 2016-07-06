class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions

  attr_reader :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: ["#{exception.message}"] }
  end

  protected

  def payload(user)
    return nil unless user and user.id

    profile = Profile.find_by(user_id: user.id)

    passions = Passion.where(user: user)

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
          passions: format_passions(passions)
        }
      }
    else
      {
        auth_token: JsonWebToken.encode({ user_id: user.id }),
        user: { 
          id: user.id, 
          email: user.email,
          profile: false,
          passions: format_passions(passions)
        }
      }
    end
  end

  def format_passions(input)
    formatted = []

    input.each do |p|
      formatted.push({
        name: p.name
      })
    end

    formatted
  end

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end

    @current_user = User.find(auth_token[:user_id])

    rescue JWT::VerificationError, JWT::DecodeError

    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end 

  private

  def http_token
    @http_token ||= request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
