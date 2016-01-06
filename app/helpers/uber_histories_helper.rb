module UberHistoriesHelper
  
  def trip_time(end_time, start_time)
    minutes = ((end_time - start_time)/60).floor
    seconds = ((end_time - start_time)%60).floor
    return "#{minutes} min #{seconds} seconds"
  end

  def min_fare(city, distance, time)
    if city == "San Francisco"
      base_fare = 2.20
      price_per_mile = 1.30 * distance
      price_per_min = 0.26 * (time/60.0)
      safe_ride_fee = 1.35
      fare = base_fare + price_per_mile + price_per_min + safe_ride_fee
      if fare > 5.35
        return fare.round(2)
      else 
        fare = 5.35
        return fare
      end
    else
      fare = "Unavailble"
    end 
  end 

  def ride_type(product_id)
    if product_id == "a1111c8c-c720-46c3-8534-2fcdd730040d"
      ride_type = "UberX"
    elsif product_id == "26546650-e557-4a7b-86e7-6a3942445247"
      ride_type = "UberPool"
    elsif product_id == "821415d8-3bd5-4e27-9604-194e4359a449"
      ride_type = "UberXl"
    else
      ride_type = "???????" 
    end
  end  




end
