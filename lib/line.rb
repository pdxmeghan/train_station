class Line
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    lines = []
    results = DB.exec("SELECT * FROM lines;")
    # binding.pry
    results.each do |result|
      name = result['name']
      id = result['id']
      lines << Line.new({:name => name, :id => id})
    end
    lines
  end

  def name
    @name
  end

  def save
    results = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_line)
    self.name == another_line.name
  end
end
