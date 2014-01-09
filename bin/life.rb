#!/usr/bin/env ruby
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require 'life'


if ARGV.length != 2
  puts """Usage: ./life.rb <board_file> <generations>

\tboard_file:\t\tText file containing the initial state of the board.
\tgenerations:\tThe number of generations to run through and print out.

Exercise 4-
------------
Write some code that evolves generations through the \"game of life\".

The input will be a game board of cells, either alive (1) or dead (0).
The code should take this board and create a new board for the next generation based on the following rules:
1) Any live cell with fewer than two live neighbours dies (under- population)
2) Any live cell with two or three live neighbours lives on to the next generation (survival)
3) Any live cell with more than three live neighbours dies (overcrowding)
4) Any dead cell with exactly three live neighbours becomes a live cell (reproduction)
"""
  exit(1)
end

board = nil
generations = nil

begin
  board = File.read ARGV[0]
rescue => e
  puts "Could not read provided board file."
  puts e
  exit(1)
end

begin
  raise "Please enter a positive integer value for the number of generations" if ARGV[1] =~ /\D+/
  generations = ARGV[1].to_i
  raise "Number of generations must be > 0" if generations < 1
rescue => e
  puts e
  exit(1)
end



# Run the sim
def print_board(board, gen)
  puts "Generation #{gen}:"
  board.each do |row|
    row.each { |col| print " #{col}" }
    puts
  end
  puts
end
life = Life.new board

print_board(life.current_board, 0)
(1..generations).each do |i|
  print_board(life.next_gen, i)
end