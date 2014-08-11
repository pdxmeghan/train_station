require 'spec_helper'

describe Line do
  it 'will initialize a line with a name' do
    test_line = Line.new({:name => 'Green'})
    expect(test_line).to be_an_instance_of Line
  end

  it 'will be the same line if they have the same name' do
    test_line1 = Line.new({:name => 'Green'})
    test_line2 = Line.new({:name => 'Green'})
    expect(test_line1).to eq test_line2
  end
end

  describe '.all' do
    it 'is empty at first' do
    expect(Line.all).to eq []
  end
end

  describe '.all' do
    it 'lists out all lines' do
      test_line1 = Line.new({:name => 'Green'})
      test_line2 = Line.new({:name => 'Blue'})
      test_line1.save
      test_line2.save
      expect(Line.all).to eq [test_line1, test_line2]
    end
  end

  describe '#save' do
    it 'saves a new line to the database' do
      test_line = Line.new({:name => 'Green', :id => 1})
      test_line.save
      expect(Line.all).to eq [test_line]
    end
  end






