Exercise 4 - Life
==============
Language: Ruby


Requirements:
==============
* Ruby >= 1.8.7
* Rake (should come with ruby. If not, "gem install rake")

Tested on MRI Ruby 1.8.7, 1.9.3, 2.1.0 on OS X.  Does not require any libraries/dependencies beyond the ruby standard lib.

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
Usage: ./bin/life.rb /path/to/board_file.txt generations

* board_file:  Text file containing the initial state of the board.
* generations: The number of generations to run through and print out.


Overview:
==============
The project is in a standard ruby/gem project structure (minus the gemfile).

* /bin executable command line interface code
* /lib core logic
* /test unit tests
* Rakefile ruby makefile