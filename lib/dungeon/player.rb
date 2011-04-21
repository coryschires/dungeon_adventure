require_relative '../dungeon'

class Player

  attr_accessor :name, :character_class, :life, :mana, :agility, :gold, :damage, :x_location, :y_location, :experience
  
  def initialize(name, character_class)
    @name = name
    @character_class = character_class
    @life = 75
    @mana = 35
    @agility = 35
    @gold = 25
    @damage = 8
    @x_location = 2
    @y_location = 13
    @experience = 0
  end
  
  # move in the dungeon
  def move(direction, map)
    x = @x_location
    y = @y_location
    
    case direction
    when :north then y -= 1
    when :south then y += 1      
    when :west then x -= 1
    when :east then x += 1   
    end
    
    unless map[y][x].is_a_wall?
      @x_location = x
      @y_location = y
    end      
  end
  
  # attack monster
  def attack(monster)
    if dice_roll > 90
      puts "You rush forward to attack, but miss pathetically."
      puts
    else
      damage = @damage.randomize
      monster.life -= damage
      puts "You rush forward to attack, inflicting #{damage.to_s} points of damage."
      puts
    end
    monster.attack(self) unless monster.is_dead? 
  end
  
  # attempt to flee monster
  def flee(monster)
    if dice_roll < @agility
      puts "-----  Nice!  -----".top_border
      puts "You've made a deft escape.".bottom_border
      return true 
    else
      puts "Oh no! Your escape was blocked."
      monster.attack(self)
      return false
    end  
  end    
  
  # check if player is dead
  def is_dead?
    @life <= 0
  end
  
  # returns coordinates player's current location
  def coordinates
    [@y_location, @x_location]
  end

end


