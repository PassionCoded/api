class PassionsController < ApplicationController
  before_filter :authenticate_request!

  def create
    @user = User.find(current_user.id)

    if params[:passions].class != Array
      render json: { errors: ['Passions must be an array of passion objects'] }, status: 400
    else
      @passions = passion_params[:passions]
      if verify_passions
        process_passions
        render json: payload(@user)
      else
        render json: { errors: ['Passions data formatted incorrectly or is blank'] }, status: 400
      end
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
      current_passions_names = []

      Passion.where(user: current_user).each do |p|
        current_passions_names.push p.name
      end

      next if current_passions_names.include? passion[:name]

      passion.save
    end
  end
end
