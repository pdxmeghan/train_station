require 'spec_helper'

describe 'Station' do

  it 'should create an instance' do
    test_station = Station.new({:name => 'name'})
    expect(test_station).to be_an_instance_of Station
  end

  it 'should start with an empty array' do
    expect(Station.all).to eq []
  end

  it 'will be the same station if it has the same name' do
    test_station1 = Station.new({:name => 'SE 46th and Division'})
    test_station2 = Station.new({:name => 'SE 46th and Division'})
    expect(test_station1).to eq test_station2
  end

  describe '.all' do
    it 'will list all of the stations' do
      test_station = Station.new({:name => 'SE 46th and Division'})
      test_station.save
      expect(Station.all).to eq [test_station]
    end
  end

  describe '#save' do
    it 'will save a new station' do
      test_station = Station.new({:name => 'SE 46th and Division'})
      test_station.save
      expect(Station.all).to eq [test_station]
    end
  end
end
