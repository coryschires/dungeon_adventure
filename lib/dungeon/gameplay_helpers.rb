require_relative '../dungeon'

class Fixnum
  # takes a number and varies it by 20 percent
  def randomize
    (self + rand((self * 0.20).to_i)).round
  end
end


class String
  # get the last character from a string
  def last_character
    self.slice(-1).chr
  end 
end

# simulate 100 sided dice roll 
def dice_roll
  1 + rand(100)
end

# clears the terminal window - fakes an ajax-like effect
def clear_screen
  system "clear"
end

def move_keystroke_is_valid(keystroke)
  valid_keys = ['A', 'B', 'C', 'D']
  valid_keys.include?(keystroke)
end

# reads the users keystroke similar to <tt>gets</tt> but:
#   (a) allows special arrow keys as inputs
#   (b) enables raw (not having to press enter)
#   (c) disables echoing (printing keystroke char)
def read_keystroke
  $stdin.flush
  
  # store state of stty
  old_state_of_stty = `stty -g`

  # disable echoing and enable raw
  system "stty raw -echo"
  
  keystroke = STDIN.getc.chr

  # gather next two characters of special keys
  if keystroke == "\e"
    extra_thread = Thread.new{
      keystroke += STDIN.getc.chr
      keystroke += STDIN.getc.chr
    }
    
    # wait just long enough for special keys to get swallowed
    extra_thread.join(0.00001)
    
    # kill thread so not-so-long special keys don't wait on getc
    extra_thread.kill
  end

  # restore previous state of stty
  system "stty #{old_state_of_stty}"

  return keystroke
end