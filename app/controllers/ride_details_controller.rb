class RideDetailsController < ApplicationController

  def index
    if params[:origin] && params[:destination]  
      @origin = Geocoder.coordinates(params[:origin]) 
      @destination = Geocoder.coordinates(params[:destination])
      client = Uber::Client.new do |config|
        config.server_token  = "S2LfgFEZbyVeZUgXYQT3Iip6eXyJd-cIYe0_ONqh"
        config.client_id     = "fGwwHohCMLIg0scb3alOrIodW_IvS4i6"
        config.client_secret = "lWg4iYZHk9fqpF6iJJmekiTImMmch8VIXED7WOts"
      end
      
      client = Uber::Client.new do |config|
        config.server_token  = "S2LfgFEZbyVeZUgXYQT3Iip6eXyJd-cIYe0_ONqh"
      end
      
      @estimations = client.price_estimations(start_latitude: @origin[0], start_longitude: @origin[1], end_latitude: @destination[0], end_longitude: @destination[1])
    
      @google_bus_data = Unirest.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@origin[0]},#{@origin[1]}&destinations=#{@destination[0]},#{@destination[1]}&mode=transit&transit_mode=bus&units=imperial&key=AIzaSyB2G7am0bauHxGoaGR3Kub2dX9SfmqgU34").body 
    
    end 
      
  end

  def surge_view
    @start_lat = params[:orgin][1..8].to_f
    @start_lng = params[:orgin][13..22].to_f
    end_lat = params[:destination][1..8].to_f
    end_lng = params[:destination][13..22].to_f
    @surge_hash = surgeAvoider(@start_lat, @start_lng, end_lat, end_lng).to_a
  end



  private

    def surgeAvoider (start_latitude, start_longitude, end_latitude, end_longitude)
      client = Uber::Client.new do |config|
        config.server_token  = "S2LfgFEZbyVeZUgXYQT3Iip6eXyJd-cIYe0_ONqh"
        config.client_id     = "fGwwHohCMLIg0scb3alOrIodW_IvS4i6"
        config.client_secret = "fTsJE5gQSqIxaBiK7IEQLXJZUykM7rX-UMIqt58x"
      end

      client = Uber::Client.new do |config|
        config.server_token  = "S2LfgFEZbyVeZUgXYQT3Iip6eXyJd-cIYe0_ONqh"
      end

      latitude_adjuster = 0.00144570
      longitude_length = Math::cos(start_latitude) * 40075
      longitude_adjuster = 0.160934 * (360/longitude_length)
      estimations = client.price_estimations(start_latitude: start_latitude, start_longitude: start_longitude,
                                              end_latitude: end_latitude, end_longitude: end_longitude)
      count = 1
      multiplier = 1
      surge_coordinates_hash = {}
      p estimations[0].surge_multiplier
      one_counter = 0


      # until estimations[0].surge_multiplier == 1
      until one_counter == 2
        if count == 1
          start_latitude = start_latitude + latitude_adjuster * multiplier
          estimations = client.price_estimations(start_latitude: start_latitude, start_longitude: start_longitude,
                                              end_latitude: end_latitude, end_longitude: end_longitude)
          count +=1
          p start_latitude
          p start_longitude
          surge_coordinates_hash[[start_latitude,start_longitude]] = estimations[0].surge_multiplier 
          if estimations[0].surge_multiplier == 1
            one_counter += 1
          end  
        elsif count == 2
          start_longitude = start_longitude + longitude_adjuster * multiplier
          estimations = client.price_estimations(start_latitude: start_latitude, start_longitude: start_longitude,
                                              end_latitude: end_latitude, end_longitude: end_longitude)
          count +=1
          multiplier +=1
          p start_latitude
          p start_longitude
          surge_coordinates_hash[[start_latitude,start_longitude]] = estimations[0].surge_multiplier 
          if estimations[0].surge_multiplier == 1
            one_counter += 1
          end 
        elsif count == 3
          start_latitude = start_latitude + latitude_adjuster*(-multiplier)
          estimations = client.price_estimations(start_latitude: start_latitude, start_longitude: start_longitude,
                                              end_latitude: end_latitude, end_longitude: end_longitude)
          count +=1
          p start_latitude
          p start_longitude
          surge_coordinates_hash[[start_latitude,start_longitude]] = estimations[0].surge_multiplier 
          if estimations[0].surge_multiplier == 1
            one_counter += 1
          end 
        else
          start_longitude = start_longitude + longitude_adjuster*(-multiplier)
          estimations = client.price_estimations(start_latitude: start_latitude, start_longitude: start_longitude,
                                              end_latitude: end_latitude, end_longitude: end_longitude)
          count -=3
          multiplier +=1
          p start_latitude
          p start_longitude
          surge_coordinates_hash[[start_latitude,start_longitude]] = estimations[0].surge_multiplier 
          if estimations[0].surge_multiplier == 1
            one_counter += 1
          end 
        end    
      end

      return surge_coordinates_hash

    end
  

end
