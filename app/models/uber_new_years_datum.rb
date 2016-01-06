class UberNewYearsDatum < ActiveRecord::Base


  def self.new_years_data(district)
    client = Uber::Client.new do |config|
      config.server_token  = ENV['SERVER_TOKEN']
    end

    if district == "Nob Hill"
      start_lat = 37.7929521
      start_lng = -122.4204894
    elsif district == "Marina"
      start_lat = 37.8019941
      start_lng = -122.4458579
    elsif district == "Soma"
      start_lat = 37.7808483
      start_lng = -122.4199278  
    elsif district == "Mission"
      start_lat = 37.7599373
      start_lng = -122.4343564
    elsif district == "Richmond"
      start_lat = 37.7802235
      start_lng = -122.5141971
    elsif district == "Haight"
      start_lat = 37.7700103
      start_lng = -122.45359511   
    end

    end_lat = 37.8201814
    end_lng = -122.3864967

    price_request = client.price_estimations(start_latitude: start_lat, start_longitude: start_lng,
                         end_latitude: end_lat, end_longitude: end_lng)
    time_request = client.time_estimations(start_latitude: start_lat, start_longitude: start_lng)

    UberNewYearsDatum.create(ride_type:price_request[0]["display_name"], neighborhood: district, surge_multiplier:(price_request[0]["surge_multiplier"]), time_estimate:time_request[0]["estimate"])
  end

end
