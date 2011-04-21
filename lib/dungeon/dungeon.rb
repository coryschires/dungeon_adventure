require_relative '../dungeon'

class Dungeon

  # set variables to make dungeon map human readable
  X = :wall
  _ = :room
  e = :end_of_game
        
  # store the map in a class variable as an array of arrays
  @@map = [
    [ X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X ],
    [ X, X, X, X, X, X, X, _, _, _, _, _, _, _, _, _, X ],
    [ X, X, X, X, X, X, X, _, X, X, X, X, X, X, X, _, X ],
    [ X, _, _, _, _, _, _, _, X, _, _, _, _, _, _, _, X ],
    [ X, _, X, X, X, X, X, X, X, _, _, _, _, X, X, X, X ],
    [ X, _, X, X, X, X, X, X, X, _, _, _, _, X, X, X, X ],
    [ X, _, _, _, _, _, _, X, X, _, _, _, _, _, _, _, X ],
    [ X, X, X, X, X, X, _, X, X, _, X, X, X, X, X, _, X ],
    [ X, X, X, X, X, X, _, X, X, _, X, X, X, X, X, _, X ],
    [ X, X, _, _, _, _, _, X, X, _, _, _, _, _, X, _, X ],
    [ X, X, _, _, _, _, _, X, X, _, _, _, _, _, X, X, X ],
    [ X, X, _, _, _, _, _, X, X, _, _, _, _, _, X, X, X ],
    [ X, X, _, _, _, _, _, X, X, _, _, _, _, _, X, X, X ],
    [ X, X, _, _, _, _, _, X, X, _, _, _, _, _, X, X, X ],
    [ X, X, X, X, X, X, X, X, X, X, X, X, X, _, X, X, X ],
    [ X, e, _, _, _, _, _, _, _, _, _, _, _, _, X, X, X ],
    [ X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X ] 
  ]

  # create an array of monsters to patrol the dungeon
  @@monsters = [
    Monster.new("a group of nasty slimes", 10, 5, 2, Monster::A_GROUP_OF_NASTY_SLIMES, 10), 
    Monster.new("some mean looking ghosts", 10, 5, 2, Monster::SOME_MEAN_LOOKIN_GHOSTS, 10),
    Monster.new("a dancing skeleton", 15, 25, 3, Monster::A_DANCING_SKELETON, 10),
    Monster.new("a wolf on the internet", 15, 35, 5, Monster::A_WOLF_ON_THE_INTERNET, 12),
    Monster.new("a sad furry", 15, 35, 5, Monster::A_SAD_FURRY, 10),
    Monster.new("a skeleton watching tv", 20, 60, 25, Monster::A_SKELETON_WATCHING_TV, 10),
    Monster.new("a pair of luv dragons", 30, 100, 20, Monster::A_PAIR_OF_LUV_DRAGONS, 50)
  ]

  # and create a boss monster for the end of the game
  @@boss_monster = Monster.new("a really scary dragon", 200, 2500, 50, Monster::A_REALLY_SCARY_DRAGON, 100)
  
  # dungeons need players, monsters, and a map
  attr_accessor :player, :monsters, :map

  # method to create a dungeon
  def initialize(player)
    @player = player
    @map = @@map
    @monsters = @@monsters
  end
  
  # print the dungeon map to screen
  def print_map
    puts "LIFE: #{player.life}        GOLD: #{player.gold}        EXPERIENCE: #{player.experience}".border
    puts
    puts "-- Dungeon Map --".align_center
    puts
    puts_formatted_dungeon_map
    puts
    puts "--- Use arrow keys to move. Beware lurking monsters ---".border
  end
  
  # prompt player to move
  def prompt_player_to_move
    
    direction = read_keystroke.last_character.upcase
    if move_keystroke_is_valid(direction)
      case direction
      when 'A' then player.move(:north, map)
      when 'B' then player.move(:south, map)
      when 'C' then player.move(:east, map)
      when 'D' then player.move(:west, map)
      end
      print_map
    end
  end
  
  def conjure_monster
    monster = monsters.sample
    monster_life = monster.life
    puts "Oh No! You have encountered a #{monster.name}.".border
    monster.graphic.print_centered
    
    until monster.is_dead? || player.is_dead?
      
      response = "Waiting for player to press '1' or '2'"
      until response == 1 || response == 2
        puts
        puts "What would you like to do?".top_border
        puts "Press '1' to attack  --- OR ---  Press '2' to flee.".bottom_border
        response = read_keystroke.to_i
      end
      
      sleep 0.5 # pause for better ui
      
      if response == 1 # attack
        player.attack(monster)
      end  
        
      if response == 2 # flee
        break if player.flee(monster)
      end
      
    end

    if monster.is_dead?
      player.experience += monster.experience
      player.gold += monster.gold       
      puts "-----  Good work!  -----".top_border
      puts "You've killed the monster.".bottom_border
    end
    
    # restore the monsters life to normal
    monster.life = monster_life.randomize
  end
  
  private 

  # formats dungeon map for screen
  def puts_formatted_dungeon_map
    
    # reset the player's old location to :room
    map.each { |subarray| subarray[subarray.index(0)] = :room if subarray.include?(0) }
  
    # set the player's current location to '0's
    map[player.coordinates.first][player.coordinates.last] = 0
        
    # (a) convert to string, (b) replace :wall with 'X' and :room with '_', (c) replace ']' with '\n' (d) delete ',' and '['  
    formatted_map = map.inspect.gsub(/:wall/, "X").gsub(/:room|:end_of_game/, "_").gsub(/\],|\]\]/, "\n").delete(',').delete('[')

    # center the map on the screen
    formatted_map.each_line { |line| puts line.strip.align_center }

  end
 
end

# booleans to cleanly check player's location
class Symbol
  def is_a_wall?
    self == :wall 
  end
  
  def is_a_room?
    self == :wall
  end
  
  def is_end_of_game
    self == :end_of_game
  end  
end 

class Array
  def end_of_game?
    self == [15,1]
  end
end                                                              