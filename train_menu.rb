require './lib/line'
require './lib/station'
require 'pg'
require 'pry'
DB = PG.connect({:dbname => 'train_system_test'})


def main_menu
  loop do
  puts "\n Welcome to the Train Manager\n"
  puts "Press 'll' to list all the train lines"
  puts "Press 'al' to add a train line"
  puts "Press 'ls' to list all stations"
  puts "Press 'as' to add a station"
  puts "Press 'at' to add a stop on a line"
  puts "Press 'lt' to see all stops on a line"
  puts "press 'x' to exit"
  main_choice = gets.chomp
    if main_choice == 'll'
      all_lines
    elsif main_choice == 'al'
      add_line
    elsif main_choice == 'ls'
      all_stations
    elsif main_choice == 'as'
      add_station
    elsif main_choice == 'at'
      add_stop
    elsif main_choice == 'lt'
      list_stops
    elsif main_choice == 'x'
      exit
      puts "Adios!"
    else
      puts "Sorry, that was not a valid choice, please enter a menu option."
    end
  end
end

def add_line
  puts "Enter the name of the train line"
  line_name = gets.chomp
  @line = []
  line_result = Line.new({:name => line_name})
  @line << line_result.save
  puts "\nLine added\n"
  all_lines
  puts "Would you like to add stops to a line? Yes or No"
  yesno_choice = gets.chomp
  if yesno_choice == 'yes' || 'Yes' || 'y' || 'Y'
    puts "Which line would you like to add stops to?"
    @line_choice = gets.chomp
    add_stop
  else
    main_menu
  end
end

def add_stop
  selected_line_id = ("SELECT id FROM lines WHERE name = '#{@line_choice}';")
  if Station.all.length = 0
    puts "Sorry! There are no stations. Please add a station now."
    add_station
  else
    Station.all.each do |station|
      puts station.name
    end
    puts "Which station would you like to add to the stop?"
    station_choice = gets.chomp
  end
  if Station.all.includes?(station_choice)
    station_choice_id = ("SELECT id FROM stations WHERE name = '#{station_choice}';")
  else
    puts "Oops! Please check your station name, that station is not in the list."
    add_stop
  end
  Stop.new(selected_line_id, station_choice_id).save
  puts "\nYour stop has been saved!\n"
end

def list_stop
  puts "Pick a line to show all of its stops"
  Line.all.each do |line|
    puts line.name
  end
  line_input = gets.chomp
  if Line.all.includes?(line_input)
    selected_line_id = DB.exec("SELECT id FROM line WHERE name = line_input;")

    stops_results = DB.exec("SELECT stations.* from
      lines JOIN stops on (lines.id = stops.line_id)
    JOIN stations on (stops.station_id = stations.id)
    WHERE lines.id = selected_line_id;")

    puts "\n\n Here are the station stops for the line: #{line_input}\n"
    stops_results.each do |station|
      puts station.name
    end
  end
end


def all_lines
    Line.all.each do |line|
      puts line.name
    end
    # binding.pry
end

def add_station
  puts "Enter the name of the station"
  station_name = gets.chomp
  @station = []
  station_result = Station.new({:name => station_name})
  @station << station_result.save
  puts "\nStation added\n"
end

def all_stations
  Station.all.each do |station|
    puts station.name
  end
end
main_menu
