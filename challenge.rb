require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require

input = File.read('./input.txt')
num_switches = input.lines[0].to_i
runs = []

input.lines[1..-1].each do |line|
  range = line.split(' ').map(&:chomp).map(&:to_i).sort
  runs << range
end

row = Switches::Row.new(num_switches)

runs.each do |run|
  puts "\n      Toggling switches #{run[0]} through #{run[1]}..."
  row.toggle_switches(run[0], run[1])
  puts "           Number of switches on: #{row.total_on}"
  puts "\n*----------------------------------------------*"
end

puts "\n\n       Final number of switches on: #{row.total_on}"
