class PassionsController < ApplicationController
  before_filter :authenticate_request!

  def create
    @user = User.find(params[:user_id])

    @profile = Profile.find_by(user: @user)

    @passions = process_passions(passion_params[:passions])
    
    render json: payload(@user, @profile, @passions)
  end

  private

  def passion_params
    params.permit(:passions => [:name])
  end

  def process_passions(passions_array)
    saved_passions = []

    if passions_array.class != Array
      render json: { errors: ['Passions data must be an array'] }, status: 400
    else
      passions_array.each do |passion|
        @passion = Passion.new(name: passion[:name])

        if @passion.save
          saved_passions.push(@passion)
        else
          render json: { errors: @passion.errors.full_messages }, status: 422
        end
      end
    end

    format_passions(saved_passions)
  end

  def format_passions(input)
    formatted = []

    input.each do |p|
      formatted.push({
        name: p.name
      })
    end

    pp "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    pp formatted
    formatted
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
