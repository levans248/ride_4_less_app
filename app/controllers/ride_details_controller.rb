class RideDetailsController < ApplicationController

  def index
    @origin = Geocoder.coordinates(params[:origin])
    @destination = Geocoder.coordinates(params[:destination])
  end

end
