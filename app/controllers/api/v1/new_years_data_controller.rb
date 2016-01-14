class Api::V1::NewYearsDataController < ApplicationController

  def index
    if params[:linkClicked] == "surge_vs_wait_time"  
      @ride_data = ride_and_surge_data(params[:filter])
      render json: @ride_data
    elsif params[:linkClicked] == "surge_vs_time_of_day"
      @ride_data = new_years_eve_to_new_years_morning(params[:filter])
      render json: @ride_data
    elsif params[:linkClicked] = "wait_time_vs_time_of_day"
      @ride_data = new_years_eve_to_new_years_morning(params[:filter])
      render json: @ride_data
    end  
  end



  private

  def ride_and_surge_data(filter)
    if filter == "all"
      ride_data = UberNewYearsDatum.all
    else
      ride_data = UberNewYearsDatum.where("neighborhood = ?", filter)  
    end  
  end

  def new_years_eve_to_new_years_morning(filter)
    if filter == "all"
      ride_data = UberNewYearsDatum.where(created_at: ("2015-12-31 17:00:00".."2016-01-01 05:00:00"))
    else
      ride_data = UberNewYearsDatum.where('neighborhood = ?', filter).where(created_at: ("2015-12-31 18:00:00".."2016-01-01 05:00:00")) 
    end  
  end


end

