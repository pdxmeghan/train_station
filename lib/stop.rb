class Stop

  attr_accessor :line_id, :station_id, :id

  def initialize(line_id, station_id)
    @line_id = line_id
    @station_id = station_id
  end

  def self.all
    stops = []
    results = DB.exec("SELECT * FROM stops")
    results.each do |stop|
      line_id = stop['line_id']
      station_id = stop['station_id']
      stops << Stop.new(line_id = line_id, station_id = station_id)
    end
    stops
  end

  def save
    results = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{@line_id}, #{@station_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_stop)
    @line_id == another_stop.line_id && @station_id == another_stop.station_id
  end
end
