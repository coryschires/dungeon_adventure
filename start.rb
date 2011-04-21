require_relative 'lib/dungeon.rb'

clear_screen
puts %q{
   ___                              _____   _             _ 
  |    \ _ _ ___ ___ ___ ___ ___   |  _  |_| |_ _ ___ ___| |_ _ _ ___ ___ 
  |  |  | | |   | . | -_| . |   |  |     | . | | | -_|   |  _| | |  _| -_|
  |____/|___|_|_|_  |___|___|_|_|  |__|__|___|\_/|___|_|_|_| |___|_| |___|
                |___|
                                        ...a text-based rpg built in ruby


}
puts "Welcome to the dungeon. Please create you player.\n\n"

# get player's name
name = nil
while name.blank?
  print "Player Name: "
  name = gets.chomp
end

# get player's character class
character_class = nil
while character_class.blank?
  print "Character Class: "
  character_class = gets.chomp
end

# create player and dungeon
player = Player.new(name, character_class)
dungeon = Dungeon.new(player)

# start the adventure
clear_screen
dungeon.print_map
dungeon.prompt_player_to_move
game_is_active = true

while game_is_active
  
  # clear the screen at the start of each loop
  clear_screen
  
  # check if player has completed the game
  if player.coordinates.end_of_game?
    puts "-----  Congrats!  -----".fancy_border
    puts "You've completed the dungeon adventure!\n".bottom_border
    game_is_active = false

  # battle a monster every fifth move
  elsif dice_roll < 20 
    dungeon.conjure_monster
    sleep 1
    clear_screen
    
    # check if player is still alive after battle     
    if player.is_dead?
      puts "-----  Oh no! You are dead.  -----".fancy_border
      puts "Better luck next time.\n".bottom_border
      game_is_active = false
    end
  end

  # show map if game is still active
  if game_is_active
    dungeon.print_map
    dungeon.prompt_player_to_move
  end
  
end