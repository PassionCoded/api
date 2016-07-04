class PassionsController < ApplicationController
  before_filter :authenticate_request!

  def create
    @user = User.find(params[:user_id])

    @passions = passion_params[:passions]

    process_passions(@passions)
  end

  private

  def passion_params
    params.permit(:passions => [:name])
  end

  def process_passions(passions_array)
    if passions_array.class != Array
      render json: { errors: ['Passions data must be an array'] }, status: 400
    else
      passions_array.each do |passion|
        puts passion
      end
    end
  end
end
