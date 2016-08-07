class PassionsController < ApplicationController
  before_filter :authenticate_request!

  def create
    @user   = User.find(current_user.id)
    @error = nil
    @error_messages = {
      1 => { errors: ['Passions data formatted incorrectly'] },
      2 => { errors: ['Passions data cannot be blank'] },
      3 => { errors: ['Passions data already exists'] },
    }

    if params[:passions].class != Array
      render json: { errors: ['Passions must be an array of passion objects'] }, status: 400
    else
      @passions = passion_params[:passions]
      if verify_passions
        process_passions
        render json: payload(@user)
      else
        render json: @error_messages[@error], status: 400
      end
    end
  end

  private

  def passion_params
    params.permit(:passions => [:name])
  end

  def verify_passions
    current_passions_names = []

    Passion.where(user: current_user).each do |p|
      current_passions_names.push p.name
    end

    @passions.each do |p|
      if !p.keys.include? "name" || !p["name"].is_a?(String) || !!p["name"] == p["name"]
        @error = 1
        return false
      elsif p["name"] == ""
        @error = 2 
        return false 
      elsif current_passions_names.include? p[:name]
        @error = 3
        return false
      end
    end

    true
  end

  def process_passions
    @passions.each do |passion|
      passion[:name] = passion[:name].downcase if passion[:name].class == String
    end

    @passions.uniq!

    @passions.each do |passion|
      passion = Passion.new(name: passion[:name], user: @user)

      passion.save
    end
  end
end
