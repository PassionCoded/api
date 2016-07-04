class ProfilesController < ApplicationController
  before_filter :authenticate_request!

  # def show
  #   @profile = Profile.find_by(user_id: params[:user_id])

  #   @passions = Passion.where(user_id: params[:user_id])

  #   render json: payload(@profile.user, @profile)
  # end

  def create
    @user = User.find(params[:user_id])

    @profile = Profile.new(profile_params)
    @profile.user = @user
    authorize! :create, @profile

    if @profile.save
      render json: payload(@user, @profile)
    else
      render json: { errors: @profile.errors.full_messages }, status: 422
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :profession, :tech_of_choice, :years_experience, :willing_to_manage)
  end

  def payload(user, profile, passions=[])
    {
      user: {
        id: user.id,
        email: user.email,
        profile: {
          first_name: profile.first_name,
          last_name: profile.last_name,
          profession: profile.profession,
          tech_of_choice: profile.tech_of_choice,
          years_experience: profile.years_experience,
          willing_to_manage: profile.willing_to_manage,
        },
        passions: passions
      }
    }
  end
end
