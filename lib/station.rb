class Station

  attr_accessor :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def self.all
    stations = []
    results = DB.exec("SELECT * FROM stations")
    results.each do |station|
      name = station['name']
      id = station['id']
      stations << Station.new({:name => name, :id => id})
    end
    stations
  end

  def save
    results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_station)
    @name == another_station.name
  end
end
