module UberHistoriesHelper
  
  def trip_time(end_time, start_time)
    minutes = ((end_time - start_time)/60).floor
    seconds = ((end_time - start_time)%60).floor
    return "#{minutes} min #{seconds} seconds"
  end

end
