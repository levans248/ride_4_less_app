class Api::V1::NewYearsDataController < ApplicationController

  def index
    @ride_data = ride_and_surge_data(params[:filter])
    render json: @ride_data
  end



  private

  def ride_and_surge_data(filter)
    if filter == "all"
      ride_data = UberNewYearsDatum.all
    else
      ride_data = UberNewYearsDatum.where("neighborhood = ?", filter)  
    end  
  end

  def surge_vs_time_of_day(filter)
    if filter == "all"
      ride_data = UberNewYearsDatum.where(created_at: ("2015-12-31 17:00:00".."2016-01-01 06:00:00")).order(:id).pluck(:id, :created_at, :surge_multiplier)
    else
      ride_data = UberNewYearsDatum.where('neighborhood = ?', filter).where(created_at: ("2015-12-31 17:00:00".."2016-01-01 06:00:00")).order(:id).pluck(:id, :created_at, :surge_multiplier)  
    end  
  end


end

