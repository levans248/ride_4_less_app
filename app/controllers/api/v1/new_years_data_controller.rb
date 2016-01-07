class Api::V1::NewYearsDataController < ApplicationController

  def index
    @ride_data = ride_and_surge_data(params[:filter])
    render json: @ride_data
  end



  private

  def ride_and_surge_data(mode)
    if mode == "all"
      ride_data = UberNewYearsDatum.all
    else
      ride_data = UberNewYearsDatum.where("neighborhood = ?", mode)  
    end  
  end


end
