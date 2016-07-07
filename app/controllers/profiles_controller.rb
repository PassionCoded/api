class ProfilesController < ApplicationController
  before_filter :authenticate_request!

  def create
    @user = User.find(current_user.id)

    if verify_profile_params
      @profile = Profile.new(profile_params)
      @profile.user = @user
      authorize! :create, @profile

      if @profile.save
        render json: payload(@user)
      else
        render json: { errors: @profile.errors.full_messages }, status: 422
      end
    else
      render json: { errors: ['One or more profile fields is missing or empty'] }, status: 400
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :profession, :tech_of_choice, :years_experience, :willing_to_manage)
  end

  def verify_profile_params
    required_fields = [:first_name, :last_name, :profession, :tech_of_choice, :years_experience, :willing_to_manage]

    required_fields.each do |field|
      return false if profile_params[field].nil? || profile_params[field] == ""
    end

    true
  end
end
