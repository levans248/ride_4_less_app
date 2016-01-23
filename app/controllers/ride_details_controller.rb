class RideDetailsController < ApplicationController

  def index  
    if params[:origin] == "" || params[:destination]== "" 
      flash[:danger] = "Neither Pick Up Address nor Drop Off Address can be blank.  Please try again!"
      redirect_to "/"
    else  
      if params[:origin] && params[:destination]   
        @origin = Geocoder.coordinates(params[:origin])
        @destination = Geocoder.coordinates(params[:destination])
        @google_bus_data = Unirest.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@origin[0]},#{@origin[1]}&destinations=#{@destination[0]},#{@destination[1]}&mode=transit&transit_mode=bus&units=imperial&key=#{ENV['GOOGLE_MAPS_API_KEY']}").body
        if @google_bus_data["rows"][0]["elements"][0]["status"] == "ZERO_RESULTS"
          flash[:danger] = "I'm Sorry, no bus routes available to your destination.  Please try again."
          redirect_to "/"
        else  
          client = Uber::Client.new do |config|
            config.server_token  = ENV['SERVER_TOKEN']
          end
          if @origin == nil || @destination == nil
            flash[:danger] = "A valid Pickup Address and Drop Off Address are required.  Please try again!"
            redirect_to "/"
          else          
            if @google_bus_data["rows"][0]["elements"][0]["distance"]["text"][0..-4].delete(",").to_i.to_s.length < 3 
              client = Uber::Client.new do |config|
                config.server_token  = ENV['SERVER_TOKEN']
                config.client_id     = ENV['CLIENT_ID']
                config.client_secret = ENV['CLIENT_SECRET']
              @estimations = client.price_estimations(start_latitude: @origin[0], start_longitude: @origin[1], end_latitude: @destination[0], end_longitude: @destination[1])
              end
              @start_lat = @origin[0]
              @start_lng = @origin[1]
              end_lat = @destination[0]
              end_lng = @destination[1]
              @surge_hash = surgeAvoider(@start_lat, @start_lng, end_lat, end_lng).to_a
            else
              flash[:danger] = "Pickup Address and Drop Off location must be within 100 miles of eachother.  Currently, your request is #{@google_bus_data["rows"][0]["elements"][0]["distance"]["text"]}les."
              redirect_to "/ride_details"
            end
          end
        end    
      end 
    end   
  end


  # privacy action and view required by uber api
  def privacy

  end

  private

    def surgeAvoider (start_latitude, start_longitude, end_latitude, end_longitude)
      client = Uber::Client.new do |config|
        config.server_token  = ENV['SERVER_TOKEN']
        config.client_id     = ENV['CLIENT_ID']
        config.client_secret = ENV['CLIENT_SECRET']
      end

      client = Uber::Client.new do |config|
        config.server_token  = ENV['SERVER_TOKEN']
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
