class PassionsController < ApplicationController
  before_filter :authenticate_request!

  def create
    @user = User.find(current_user.id)

    @passions = passion_params[:passions]

    if verify_passions
      process_passions
      render json: payload(@user)
    else
      render json: { errors: ['Passions data formatted incorrectly or is blank'] }, status: 400
    end
  end

  private

  def passion_params
    params.permit(:passions => [:name])
  end

  def verify_passions
    if @passions.class != Array
      false
    else
      @passions.each do |p|
        return false unless p.keys.include? "name"
        return false unless p["name"].class == String
        return false if p["name"] == ""
      end
    end

    true
  end

  def process_passions
    @passions.each do |passion|
      passion = Passion.new(name: passion[:name], user: @user)

      passion.save
    end
  end
end
