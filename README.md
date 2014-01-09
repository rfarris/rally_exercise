Exercise 4 - Life
==============


Requirements:
==============
* Ruby
* Rake (should come with ruby. If not, "gem install rake")

Tested on MRI Ruby 1.8.7, 1.9.3, 2.1.0

Running:
==============
```
git clone https://github.com/rfarris/rally_exercise.git
cd rally_exercise
rake test

./bin/life.rb test/example_in.txt 5
```



Usage:
==============
Usage: ./bin/life.rb <board_file> <generations>

  board_file:  Text file containing the initial state of the board.
  generations: The number of generations to run through and print out.