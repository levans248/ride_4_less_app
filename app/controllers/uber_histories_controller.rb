class UberHistoriesController < ApplicationController

  def index
    @histories = all_uber_rides
    @user_profile = get_client.me
    @average_ride_time = average_ride_time
    @average_distance = average_distance
  end

  def city
    @cities = all_cities 
    @cities_ride_count = all_cities_hash
    pearson_correlation_coefficient
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
