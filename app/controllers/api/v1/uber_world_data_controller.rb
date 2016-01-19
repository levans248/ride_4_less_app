class Api::V1::UberWorldDataController < ApplicationController

  def index
    if params[:linkClicked] == "surge_vs_time_of_day" || params[:linkClicked] == "wait_time_vs_time_of_day"
      @all_saturday_international_data = saturday_night_to_sunday_morning_data.to_json
      render json: @all_saturday_international_data
    elsif params[:linkClicked] == "cost_to_go_one_mile"
      @costs = cost_to_travel_one_mile.to_json
      render json: @costs  
    else
      @all_international_data = ride_and_surge_data(params[:filter])
      render json: @all_international_data  
    end
  end


  private

  def ride_and_surge_data(filter)
    if filter == "all" 
      ride_data = UberWorldDatum.all
    else
      ride_data = UberWorldDatum.where("city = ?", filter)  
    end  
  end 

  def saturday_night_to_sunday_morning_data
    san_francisco = UberWorldDatum.where("city = ?", "Nob Hill").where(created_at: ("2016-01-16 17:00:00".."2016-01-17 05:00:00"))
    no_time_change = UberWorldDatum.where(:city => ["Hollywood", "Seattle"]).where(created_at: ("2016-01-16 17:00:00".."2016-01-17 05:00:00"))
    one_hour_ahead = UberWorldDatum.where("city = ?", "Denver").where(created_at: ("2016-01-16 16:00:00".."2016-01-17 04:00:00"))
    two_hours_ahead = UberWorldDatum.where(:city => ["New Orleans", "Chicago"]).where(created_at: ("2016-01-16 15:00:00".."2016-01-17 03:00:00"))
    three_hours_ahead = UberWorldDatum.where(:city => ["Boston", "Times Square, NY"]).where(created_at: ("2016-01-16 14:00:00".."2016-01-17 02:00:00"))
    eight_hours_ahead = UberWorldDatum.where(:city => ["London"]).where(created_at: ("2016-01-16 11:00:00".."2016-01-16 23:00:00"))
    nine_hours_ahead = UberWorldDatum.where(:city => ["Paris"]).where(created_at: ("2016-01-16 10:00:00".."2016-01-16 22:00:00"))
    fifteen_hours_ahead = UberWorldDatum.where(:city => ["Bangkok"]).where(created_at: ("2016-01-16 02:00:00".."2016-01-16 14:00:00"))
    sixteen_hours_ahead = UberWorldDatum.where(:city => ["Perth", "Hong Kong"]).where(created_at: ("2016-01-16 01:00:00".."2016-01-16 13:00:00"))
    time_zone_array = [san_francisco, no_time_change, one_hour_ahead, two_hours_ahead, three_hours_ahead, eight_hours_ahead, nine_hours_ahead, fifteen_hours_ahead, sixteen_hours_ahead].flatten
    return time_zone_array
  end

  def cost_to_travel_one_mile
    no_time_change = UberWorldDatum.where(:city => ["Nob Hill", "Hollywood", "Seattle"]).where(created_at: ("2016-01-16 17:00:00".."2016-01-17 05:00:00"))
    hollywood_total = 0
    sf_total = 0
    seattle_total = 0
    sf_count = 0
    seattle_count = 0
    hollywood_count = 0
    sf_distance = 0
    seattle_distance = 0
    hollywood_distance = 0
    no_time_change.each do |request|
      average = 0
      if request.city == "Nob Hill"
        sf_count += 1
        sf_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        sf_estimate_array = sf_estimate[0].split("-")
        average = (sf_estimate_array[0].to_i + sf_estimate_array[1].to_i)/2
        sf_total = sf_total + average
        sf_distance = request.distance
      elsif request.city == "Seattle"
        seattle_count += 1
        seattle_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        seattle_estimate_array = seattle_estimate[0].split("-")
        average = (seattle_estimate_array[0].to_i + seattle_estimate_array[1].to_i)/2
        seattle_total = seattle_total + average
        seattle_distance = request.distance
      else
        hollywood_count += 1
        hollywood_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        hollywood_estimate_array = hollywood_estimate[0].split("-")
        average = (hollywood_estimate_array[0].to_i + hollywood_estimate_array[1].to_i)/2
        hollywood_total = hollywood_total + average
        hollywood_distance = request.distance
      end
    end

    one_hour_ahead = UberWorldDatum.where("city = ?", "Denver").where(created_at: ("2016-01-16 16:00:00".."2016-01-17 04:00:00"))
    denver_total = 0
    denver_count = 0
    denver_distance = 0
    average = 0
    one_hour_ahead.each do |request|
      denver_count += 1
      denver_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
      denver_estimate_array = denver_estimate[0].split("-")
      average = (denver_estimate_array[0].to_i + denver_estimate_array[1].to_i)/2
      denver_total = denver_total + average
      denver_distance = request.distance 
    end

    two_hours_ahead = UberWorldDatum.where(:city => ["New Orleans", "Chicago"]).where(created_at: ("2016-01-16 15:00:00".."2016-01-17 03:00:00"))
    new_orleans_total = 0
    new_orleans_count = 0
    new_orleans_distance = 0
    chicago_total = 0
    chicago_count = 0
    chicago_distance = 0
    two_hours_ahead.each do |request|
      average = 0
      if request.city == "Chicago"
        chicago_count += 1
        chicago_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        chicago_estimate_array = chicago_estimate[0].split("-")
        average = (chicago_estimate_array[0].to_i + chicago_estimate_array[1].to_i)/2
        chicago_total = chicago_total + average
        chicago_distance = request.distance 
      else
        new_orleans_count += 1
        new_orleans_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        new_orleans_estimate_array = new_orleans_estimate[0].split("-")
        average = (new_orleans_estimate_array[0].to_i + new_orleans_estimate_array[1].to_i)/2
        new_orleans_total = new_orleans_total + average
        new_orleans_distance = request.distance 
      end
    end

    three_hours_ahead = UberWorldDatum.where(:city => ["Boston", "Times Square, NY"]).where(created_at: ("2016-01-16 14:00:00".."2016-01-17 02:00:00"))
    new_york_total = 0
    new_york_count = 0
    new_york_distance = 0
    boston_total = 0
    boston_count = 0
    boston_distance = 0
    three_hours_ahead.each do |request|
      average = 0
      if request.city == "Times Square, NY"
        new_york_count += 1
        new_york_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        new_york_estimate_array = new_york_estimate[0].split("-")
        average = (new_york_estimate_array[0].to_i + new_york_estimate_array[1].to_i)/2
        new_york_total = new_york_total + average
        new_york_distance = request.distance 
      else
        boston_count += 1
        boston_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        boston_estimate_array = boston_estimate[0].split("-")
        average = (boston_estimate_array[0].to_i + boston_estimate_array[1].to_i)/2
        boston_total = boston_total + average
        boston_distance = request.distance 
      end
    end

    eight_hours_ahead = UberWorldDatum.where(:city => ["London"]).where(created_at: ("2016-01-16 11:00:00".."2016-01-16 23:00:00"))
    london_total = 0
    london_count = 0
    london_distance = 0
    average = 0
    eight_hours_ahead.each do |request|
      london_count += 1
      london_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
      london_estimate_array = london_estimate[0].split("-")
      average = ((london_estimate_array[0].to_i + london_estimate_array[1].to_i)/2) * 1.08
      london_total = london_total + average
      london_distance = request.distance 
    end

    nine_hours_ahead = UberWorldDatum.where(:city => ["Paris"]).where(created_at: ("2016-01-16 10:00:00".."2016-01-16 22:00:00"))
    paris_total = 0
    paris_count = 0
    paris_distance = 0
    average = 0
    nine_hours_ahead.each do |request|
      paris_count += 1
      paris_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
      paris_estimate_array = paris_estimate[0].split("-")
      average = ((paris_estimate_array[0].to_i + paris_estimate_array[1].to_i)/2) * 1.08
      paris_total = paris_total + average
      paris_distance = request.distance 
    end

    fifteen_hours_ahead = UberWorldDatum.where(:city => ["Bangkok"]).where(created_at: ("2016-01-16 02:00:00".."2016-01-16 14:00:00"))
    bangkok_total = 0
    bangkok_count = 0
    bangkok_distance = 0
    average = 0
    fifteen_hours_ahead.each do |request|
      bangkok_count += 1
      bangkok_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
      bangkok_estimate_array = bangkok_estimate[0].split("-")
      average = ((bangkok_estimate_array[0].to_i + bangkok_estimate_array[1].to_i)/2) / 36.29346
      bangkok_total = bangkok_total + average
      bangkok_distance = request.distance 
    end

    sixteen_hours_ahead = UberWorldDatum.where(:city => ["Perth", "Hong Kong"]).where(created_at: ("2016-01-16 01:00:00".."2016-01-16 13:00:00"))
    perth_total = 0
    perth_count = 0
    perth_distance = 0
    hong_kong_total = 0
    hong_kong_count = 0
    hong_kong_distance = 0
    sixteen_hours_ahead.each do |request|
      average = 0
      if request.city == "Perth"
        perth_count += 1
        perth_estimate = /.[*0-9]-[0-9]*/.match(request.estimate)
        perth_estimate_array = perth_estimate[0].split("-")
        average = ((perth_estimate_array[0].to_i + perth_estimate_array[1].to_i)/2) / 1.46
        perth_total = perth_total + average
        perth_distance = request.distance 
      else
        hong_kong_count += 1
        hong_kong_estimate = /..[*0-9]-[0-9]*/.match(request.estimate)
        hong_kong_estimate_array = hong_kong_estimate[0].split("-")
        average = ((hong_kong_estimate_array[0].to_i + hong_kong_estimate_array[1].to_i)/2) / 7.81
        hong_kong_total = hong_kong_total + average
        hong_kong_distance = request.distance 
      end
    end


    return {"SF": ((sf_total/sf_count)/sf_distance).round(2), "Seattle": ((seattle_total/seattle_count)/seattle_distance).round(2), "Hollywood": ((hollywood_total/hollywood_count)/hollywood_distance).round(2), "Denver": ((denver_total/denver_count)/denver_distance).round(2), "Chicago": ((chicago_total/chicago_count)/chicago_distance).round(2), "New Orleans": ((new_orleans_total/new_orleans_count)/new_orleans_distance).round(2), "New York": ((new_york_total/new_york_count)/new_york_distance).round(2), "Boston": ((boston_total/boston_count)/boston_distance).round(2), "London": ((london_total/london_count)/london_distance).round(2), "Paris": ((paris_total/paris_count)/paris_distance).round(2), "Bangkok": ((bangkok_total/bangkok_count)/bangkok_distance).round(2), "Perth": ((perth_total/perth_count)/perth_distance).round(2), "Hong Kong": ((hong_kong_total/hong_kong_count)/hong_kong_distance).round(2)}
  end


end
