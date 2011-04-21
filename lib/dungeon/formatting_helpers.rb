require_relative '../dungeon'

class String
  
  # set constants for consistent formating
  LENGTH = 64
  BORDER = "-" * LENGTH
  
  # center text on screen
  def align_center
    self.center(LENGTH)
  end  
  
  # add a top border to string
  def top_border
    "#{BORDER}\n #{self.align_center}"
  end

  # add a bottom border to string
  def bottom_border
    "#{self.align_center} \n#{BORDER}"
  end
  
  # add both a top and bottom border
  def border
    "#{BORDER}\n #{self.align_center} \n#{BORDER}"
  end

  def fancy_border
    half_border = "-" * ((LENGTH - 18) / 2) 
    fancy_border = 
    puts '\_/'.align_center
    puts '@ @'.align_center
    puts "#{half_border}vvvV--<o o>--Vvvvv#{half_border}"
    puts 'V^V'.align_center
    "#{fancy_border}#{self.align_center}"
  end
  
  def print_centered
    longest_line = self.each_line.max {|a,b| a.length <=> b.length }
    margin = (LENGTH - longest_line.length) / 2
    self.each_line do |line|
      margin.times do
        line = "\s" + line
      end
      puts line
    end
  end
end