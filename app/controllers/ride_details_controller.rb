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
    end  
      
  end


  

end
