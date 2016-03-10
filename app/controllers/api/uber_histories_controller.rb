class Api::UberHistoriesController < ApplicationController

  def index
    if params[:linkClicked] == "time_trends"
      @time_patterns = time_patterns.to_json
      render json: @time_patterns
    elsif params[:linkClicked] == "cities_visited"
      cities = all_cities 
      cities_ride_count = all_cities_hash
      @all_cities_data =[cities, cities_ride_count].to_json
      render json: @all_cities_data
    elsif params[:linkClicked] == "profile"
      user_profile = get_client.me
      histories = all_uber_rides
      @profile_data = [user_profile, histories, average_ride_time, average_distance].to_json
      render json: @profile_data
    end
  end


  private 

  def get_client
    client = Uber::Client.new do |config|
      config.server_token  = ENV['SERVER_TOKEN']
      config.client_id     = ENV['CLIENT_ID']
      config.client_secret = ENV['CLIENT_SECRET']
      config.bearer_token  = current_user.token
    end

    return client
  end

  def all_uber_rides
    count = get_client.history.count
    offset = 0
    all_uber_rides = []

    while count > 0 
      if count <= 50
        get_client.history(limit:count, offset:offset).histories.each do |history|
          all_uber_rides << history
          count = 0
        end
      else
        get_client.history(limit:50, offset:offset).histories.each do |history|
          all_uber_rides << history
        end  
      end
      count -= 50
      offset += 50
    end

    return all_uber_rides  
  end

  def average_ride_time
    count = get_client.history.count
    total_time_in_seconds = 0

    all_uber_rides.each do |ride|
      total_time_in_seconds = total_time_in_seconds + (ride['end_time'] - ride['start_time'])
    end
    
    average_ride_time_in_secondes = total_time_in_seconds / count
    minutes = (average_ride_time_in_secondes / 60).floor
    seconds = (average_ride_time_in_secondes % 60).floor

    return "Average Ride Time: #{minutes} min #{seconds} seconds"  
  end

  def average_distance
    count = get_client.history.count
    total_distance = 0

    all_uber_rides.each do |ride|
      total_distance = total_distance + ride['distance']
    end

      average_distance = (total_distance / count).round(2)

    return "Average Ride Distance: #{average_distance} miles"
  end

  def all_cities
    cities_array = []
    all_uber_rides.each do |ride|
      unless cities_array.include? ride['start_city'][:display_name]
        cities_array << ride['start_city'][:display_name]  
      end
    end
    return cities_array 
  end

  def all_cities_hash
    cities_hash = Hash.new(0)
    all_uber_rides.each do |ride|
      cities_hash[ride['start_city'][:display_name]] += 1
    end

    return cities_hash
  end

  def time_patterns
    times_hash = Hash.new(0)
    time_array = []
    all_uber_rides.each do |ride|
      puts ride['request_time']  
      time_array << ride['request_time'].to_s[11..12]
      if ride['request_time'].to_s[11..12] == "00" || ride['request_time'].to_s[11..12] == "01"
        times_hash[1] += 1
      elsif ride['request_time'].to_s[11..12] == "02" || ride['request_time'].to_s[11..12] == "03"
        times_hash[2] += 1
      elsif ride['request_time'].to_s[11..12] == "04" || ride['request_time'].to_s[11..12] == "05"
        times_hash[3] += 1 
      elsif ride['request_time'].to_s[11..12] == "06" || ride['request_time'].to_s[11..12] == "07"
        times_hash[4] += 1
      elsif ride['request_time'].to_s[11..12] == "08" || ride['request_time'].to_s[11..12] == "09"
        times_hash[5] += 1  
      elsif ride['request_time'].to_s[11..12] == "10" || ride['request_time'].to_s[11..12] == "11"
        times_hash[6] += 1
      elsif ride['request_time'].to_s[11..12] == "12" || ride['request_time'].to_s[11..12] == "13"
        times_hash[7] += 1
      elsif ride['request_time'].to_s[11..12] == "14" || ride['request_time'].to_s[11..12] == "15"
        times_hash[8] += 1
      elsif ride['request_time'].to_s[11..12] == "16" || ride['request_time'].to_s[11..12] == "17"
        times_hash[9] += 1
      elsif ride['request_time'].to_s[11..12] == "18" || ride['request_time'].to_s[11..12] == "19"
        times_hash[10] += 1
      elsif ride['request_time'].to_s[11..12] == "20" || ride['request_time'].to_s[11..12] == "21"
        times_hash[11] += 1
      else
        times_hash[12] += 1
      end     
    end
    return [get_client.history.count, times_hash, time_array]
    
  end

  def pearson_correlation_coefficient
    new_years_data = UberNewYearsDatum.all
    n = UberNewYearsDatum.count
    sum_of_x = 0
    sum_of_y = 0
    sum_of_xy = 0
    sum_of_x_squared = 0
    sum_of_y_squared = 0

    new_years_data.each do |ride_request|
      sum_of_x += ride_request.surge_multiplier
      sum_of_y += ride_request.time_estimate
      sum_of_xy += (ride_request.surge_multiplier + ride_request.time_estimate)
      sum_of_x_squared += (ride_request.surge_multiplier * ride_request.surge_multiplier)
      sum_of_y_squared += (ride_request.time_estimate * ride_request.time_estimate)
    end

    numerator = (n * sum_of_xy) - (sum_of_x * sum_of_y)
    denominator = ((n * sum_of_x_squared) - sum_of_x_squared)*((n * sum_of_y_squared) - sum_of_y_squared)
    square_root_of_denominator = Math.sqrt(denominator)

    r = numerator/square_root_of_denominator

    puts r

    return r
  end

end
