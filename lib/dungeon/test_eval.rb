def print_map(map)
  # (a) convert to string, (b) replace :wall with 'X' and :room with '_', (c) replace ']' with '\n' (d) delete ',' and '['
  formatted_map = map.inspect.gsub(/:wall/, "X").gsub(/:room/, "_").gsub(/\],|\]\]/, "\n").delete(',').delete('[')

  # center the map on the screen
  formatted_map.each { |line| puts line.strip.center(80) }

end

# create a random 20 x 20 map
def make_random_map
  entire_map = []
  20.times do
    single_row = []
    20.times do 
      if rand(2) == 1
        single_row << :room
      else
        single_row << :wall 
      end  
    end  
    entire_map << single_row
  end
  entire_map
end

def add_borders(map)
  # create solid walls for top and bottom of map
  map[0].collect! { |space| space = :wall }
  map[-1].collect! { |space| space = :wall }
  
  # and for each side of map
  map.each do |row|
    row[0] = :wall
    row[-1] = :wall    
  end  
end


# determin the adjacent rooms for a given set of coordinates on a map
def adjacent_rooms(map, y, x)
  
  north = map[y-1][x]
  south = map[y+1][x]
  west = map[y][x-1]
  east = map[y][x+1]

  [north, south, west, east]
end

# def coordinates(map, room)
#   
# end

def ensure_adjacent_rooms(map)
  map.each do |row|
    x_coordinate = map.index(row)
      row.each do |room|
        index = map[row].index(room)
        puts index
      end

      
    # x_coordinates = row.collect! { |room| room = row.index(room) }
      
    # x_coordinates.each { |coordin| puts coordin }  
    # 
    # row.each { |coordin| puts coordin }  
  end
end

# coordinates = []
# coordinates << y_coordinate
# coordinates << x_coordinate

def generate_map
  map = make_random_map
  map = add_borders(map)
  map = ensure_adjacent_rooms(map)
end



map = generate_map

# print_map(map)

