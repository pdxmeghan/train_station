describe 'Stop' do

  it 'creates a new stop given a station id and a line id that exist in the database' do
    test_stop = Stop.new(line_id = '3', station_id = '4')
    expect(test_stop).to be_an_instance_of Stop
  end

  it 'creates a new stop given a station id and a line id that exist in the database' do
    test_station1 = Station.new({:name => 'SE 46th and Division'})
    test_line2 = Line.new({:name => 'Blue'})
    test_stop = Stop.new(line_id = '27', station_id = '1')
    expect(test_stop).to be_an_instance_of Stop
  end

  it 'will be an empty array to start' do
    expect(Stop.all).to eq []
  end

  it 'will save a stop to the join table in the database' do
    test_stop = Stop.new(line_id = '3', station_id = '4')
    test_stop.save
    expect(Stop.all).to eq [test_stop]
  end

  it 'will be the same stop if it has the same line_id, station_id, and id' do
    test_stop1 = Stop.new(line_id = '3', station_id = '4')
    test_stop2 = Stop.new(line_id = '3', station_id = '4')
    expect(test_stop1).to eq test_stop2
  end
end
