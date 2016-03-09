# Basic bundler setup

require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require

# Read in the input file
input = File.read('./input.txt')

# lines method returns each line of the file in an array of strings
# convert that string to an integer
num_switches = input.lines[0].to_i      # "1000\n" becomes 1000

# start an empty array for each runthrough of toggling switches
runs = []

# some_array[1..-1] is how to say in ruby,
# give me the second through the last item
# so this gives us all lines in the input
# except for the first one, which we know 
# was the number of switches
input.lines[1..-1].each do |line|
  # each line looks like this:
  # "24 345\n"  (don't pay attention to the actual numbers)
  # So that is a String in Ruby, two numbers separated
  # by a space, and with a line break on the end (\n means line break in unix)
  # 
  # so we "split" the string on the space, it will look like this:
  # line == "24 345\n"
  # line.split(' ') == ["24", "345\n"]
  #
  # then we "map" that array, calling "chomp" on each item in the array
  # this special "&:chomp" is a shortcut for "call 'chomp' on each item in the array"
  # chomp is a string method to take the line break off of the end
  #
  # so following from the split above, that makes it go like this:
  # ["24", "345\n"].map(&:chomp) == ["24", "345"]
  #
  # next, we "map" again with "to_i" which means "to integer"
  # following from the chomp above:
  #
  # ["24", "345"].map(&:to_i) == [24, 345]
  #
  # finally, we sort the array so 
  # the low number is on the left side and 
  # the high number is on the right side
  # because looking at the input data, some
  # of the number pairs have a higher number before a lower number
  #
  # to reiterate, this crazy code takes this example of one line:
  # "736 459\n"
  # and goes like this:
  # "726 459\n".split(' ') => ["725", "459\n"]
  # ["725", "459\n"].map(&:chomp) => ["725", "459"]
  # ["725", "459"].map(&:to_i) => [725, 459]
  # [725, 459].sort => [459, 725]
  #
  # That all happens in this one line, because ruby lets you chain methods
  
  range = line.split(' ').map(&:chomp).map(&:to_i).sort
  
  # take that final [x, y] value and shovel it into our 'runs' array
  # << is the 'shovel' operator, a special ruby method to add items to an array
  # yes, runs is an array of arrays
  # [ [1, 2], [4, 8], ... ]
  runs << range
end

# create a new row of num_switches, which is 1000
row = Switches::Row.new(num_switches)

# go through each run in the 'runs' array
runs.each do |run|
  puts "\n      Toggling switches #{run[0]} through #{run[1]}..."
  
  # call toggle_switches on the row with the first and second value of each run
  row.toggle_switches(run[0], run[1])
  puts "           Number of switches on: #{row.total_on}"
  puts "\n*----------------------------------------------*"
end

# display the total_on value after going through all the runs
puts "\n\n       Final number of switches on: #{row.total_on}"
