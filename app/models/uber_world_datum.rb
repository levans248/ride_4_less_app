class UberWorldDatum < ActiveRecord::Base

  def self.uber_world_data(location)
    client = Uber::Client.new do |config|
      config.server_token  = ENV['SERVER_TOKEN']
    end

    if location == "Nob Hill"
      start_lat = 37.7929437
      start_lng = -122.4204894
      end_lat = 37.6929437
      end_lng = -122.4204894
    elsif location == "New Orleans"
      start_lat = 29.9594921
      start_lng = -90.0670762
      end_lat = 29.8584921
      end_lng = -90.0670762
    elsif location == "Times Square, NY"
      start_lat = 40.758895
      start_lng = -73.9873197
      end_lat = 40.658895
      end_lng = -73.9873197
    elsif location == "Chicago"
      start_lat = 41.8336478
      start_lng = -87.8722387
      end_lat = 41.7336478
      end_lng = -87.8722387
    elsif location == "Hollywood"
      start_lat = 34.0937458
      start_lng = -118.3614975
      end_lat = 34.1937458
      end_lng = -118.3614975
    elsif location == "Seattle"
      start_lat = 47.6072369
      start_lng = -122.33271
      end_lat = 47.5072369
      end_lng = -122.33271
    elsif location == "Denver"
      start_lat = 39.7642548
      start_lng = -104.995949
      end_lat = 39.8642548
      end_lng = -104.995949
    elsif location == "Boston"
      start_lat = 42.313352
      start_lng = -71.1271968
      end_lat = 42.213352
      end_lng = -71.1271968
    elsif location == "Tokyo"
      start_lat = 35.6735408
      start_lng = 139.5703023
      end_lat = 35.5735408
      end_lng = 139.5703023
    elsif location == "Paris"
      start_lat = 48.8588377
      start_lng = 2.27751174
      end_lat = 48.7588377
      end_lng = 2.27751174
    elsif location == "London"
      start_lat = 51.5285582
      start_lng = -0.2416805
      end_lat = 51.4285582
      end_lng = -0.2416805
    elsif location == "Perth"
      start_lat = -31.9546516
      start_lng = 115.8351524
      end_lat = -31.8546516
      end_lng = 115.8351524
    elsif location == "Hong Kong"
      start_lat = 22.2794966
      start_lng = 114.1644669
      end_lat = 22.3794966
      end_lng = 114.1644669
    elsif location == "Bangkok"
      start_lat = 13.724561
      start_lng = 100.4930251
      end_lat = 13.624561
      end_lng = 100.4930251
    elsif location == "Rio de Janeiro"
      start_lat = -22.9109878
      start_lng = -43.7285235
      end_lat = -22.8109878
      end_lng = -43.7285235      
    end

  


    price_request = client.price_estimations(start_latitude: start_lat, start_longitude: start_lng,
                         end_latitude: end_lat, end_longitude: end_lng)
    time_request = client.time_estimations(start_latitude: start_lat, start_longitude: start_lng)

    if location == "Hong Kong"
      UberWorldDatum.create(ride_type:price_request[3]["display_name"], city: location, surge_multiplier:(price_request[3]["surge_multiplier"]), wait_time:time_request[3]["estimate"], estimate:price_request[3]["estimate"], distance: price_request[3]["distance"])
    elsif location == "Bangkok"
      UberWorldDatum.create(ride_type:price_request[1]["display_name"], city: location, surge_multiplier:(price_request[1]["surge_multiplier"]), wait_time:time_request[0]["estimate"], estimate:price_request[1]["estimate"], distance: price_request[1]["distance"])
    else     
      UberWorldDatum.create(ride_type:price_request[0]["display_name"], city: location, surge_multiplier:(price_request[0]["surge_multiplier"]), wait_time:time_request[0]["estimate"], estimate:price_request[0]["estimate"], distance: price_request[0]["distance"])
    end
      
  end



end
