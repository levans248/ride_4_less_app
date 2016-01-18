class Api::V1::UberWorldDataController < ApplicationController

  def index
    if params[:linkClicked] == "surge_vs_time_of_day"
      @all_saturday_international_data = new_years_eve_to_new_years_morning.to_json
      render json: @all_saturday_international_data
    end
  end


  private 

  def new_years_eve_to_new_years_morning
    san_francisco = UberWorldDatum.where("city = ?", "Nob Hill").where(created_at: ("2015-01-16 17:00:00".."2016-01-17 05:00:00"))
    no_time_change = UberWorldDatum.where(:city => ["Hollywood", "Seattle"]).where(created_at: ("2015-01-16 17:00:00".."2016-01-17 05:00:00"))
    one_hour_ahead = UberWorldDatum.where("city = ?", "Denver").where(created_at: ("2015-01-16 18:00:00".."2016-01-17 06:00:00"))
    two_hours_ahead = UberWorldDatum.where(:city => ["New Orleans", "Chicago"]).where(created_at: ("2015-01-16 19:00:00".."2016-01-17 07:00:00"))
    three_hours_ahead = UberWorldDatum.where(:city => ["Boston", "Times Square, NY"]).where(created_at: ("2015-01-16 20:00:00".."2016-01-17 08:00:00"))
    eight_hours_ahead = UberWorldDatum.where(:city => ["London"]).where(created_at: ("2015-01-16 01:00:00".."2016-01-17 13:00:00"))
    nine_hours_ahead = UberWorldDatum.where(:city => ["Paris"]).where(created_at: ("2015-01-16 02:00:00".."2016-01-17 14:00:00"))
    fifteen_hours_ahead = UberWorldDatum.where(:city => ["Bangkok"]).where(created_at: ("2015-01-16 08:00:00".."2016-01-17 20:00:00"))
    sixteen_hours_ahead = UberWorldDatum.where(:city => ["Perth", "Hong Kong"]).where(created_at: ("2015-01-16 09:00:00".."2016-01-17 21:00:00"))
    time_zone_array = [san_francisco, no_time_change, one_hour_ahead, two_hours_ahead, three_hours_ahead, eight_hours_ahead, nine_hours_ahead, fifteen_hours_ahead, sixteen_hours_ahead].flatten
    return time_zone_array
  end




end
