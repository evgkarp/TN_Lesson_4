class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-2, station)    
  end

  def delete_station(station)
    @stations.delete(station) if (station != @stations[0]) && (station != @stations[-1])  
  end
end