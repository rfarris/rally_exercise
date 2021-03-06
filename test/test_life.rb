$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require 'test/unit'
require 'life'


class TestLife < Test::Unit::TestCase

  def parse_board(input)
    Life.parse_board input
  end

  def test_parse_board
    board_file = File.read('test/example_in.txt')
    expected = [
        [0, 1, 0, 0, 0],
        [1, 0, 0, 1, 1],
        [1, 1, 0, 0, 1],
        [0, 1, 0, 0, 0],
        [1, 0, 0, 0, 1]
    ]

    assert_equal expected, parse_board(board_file) # with whitespace
    assert_equal expected, parse_board(board_file.gsub /\ /, "") # without whitespace

    assert_raise(ArgumentError) do # not enough rows
      parse_board "10101"
    end
    assert_raise(ArgumentError) do # bad character
      bad_char = String.new(board_file)
      bad_char[0] = '2'
      parse_board bad_char
    end
    assert_raise(ArgumentError) { parse_board('') } # empty
    assert_raise(ArgumentError) { parse_board(board_file + "0 1") } # one row is shorter
  end


  def test_given_example
    life = Life.new parse_board(File.read('test/example_in.txt'))
    assert_equal [[0, 0, 0, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [0, 1, 0, 0, 0],
                  [0, 0, 0, 0, 0]], life.next_gen
    assert_equal [[0, 0, 0, 1, 0],
                  [1, 0, 0, 0, 1],
                  [1, 0, 0, 0, 1],
                  [1, 1, 0, 1, 0],
                  [0, 0, 0, 0, 0]], life.next_gen
  end

  def test_under_population
    # no neighbors
    assert_equal [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]], Life.new([[0, 0, 0],
                                        [0, 1, 0],
                                        [0, 0, 0]]).next_gen
    # 1 neighbor
    assert_equal [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]], Life.new([[1, 0, 0],
                                        [0, 1, 0],
                                        [0, 0, 0]]).next_gen
  end

  def test_survival
    # 2 neighbors
    assert_equal [[0, 0, 0],
                  [0, 1, 0],
                  [0, 0, 0]], Life.new([[1, 0, 0],
                                        [0, 1, 0],
                                        [0, 0, 1]]).next_gen
    # 3 neighbors
    assert_equal [[1, 1, 1],
                  [1, 1, 1],
                  [0, 0, 0]], Life.new([[1, 1, 1],
                                        [0, 1, 0],
                                        [0, 0, 0]]).next_gen
  end

  def test_reproduction
    assert_equal [[0, 0, 0],
                  [0, 1, 0],
                  [0, 0, 0]], Life.new([[1, 0, 1],
                                        [0, 0, 0],
                                        [0, 1, 0]]).next_gen
  end

  def test_overcrowding
    # 4 neighbors
    assert_equal [[1, 1, 1],
                  [1, 0, 1],
                  [1, 1, 1]], Life.new([[0, 1, 0],
                                        [1, 1, 1],
                                        [0, 1, 0]]).next_gen
    # 5 neighbors
    assert_equal [[1, 0, 1],
                  [0, 0, 1],
                  [1, 1, 1]], Life.new([[1, 1, 0],
                                        [1, 1, 1],
                                        [0, 1, 0]]).next_gen
    # 6 neighbors
    assert_equal [[1, 0, 1],
                  [0, 0, 0],
                  [1, 1, 1]], Life.new([[1, 1, 1],
                                        [1, 1, 1],
                                        [0, 1, 0]]).next_gen
    # 7 neighbors
    assert_equal [[1, 0, 1],
                  [0, 0, 0],
                  [1, 0, 1]], Life.new([[1, 1, 1],
                                        [1, 1, 1],
                                        [1, 1, 0]]).next_gen
    # 8 neighbors
    assert_equal [[1, 0, 1],
                  [0, 0, 0],
                  [1, 0, 1]], Life.new([[1, 1, 1],
                                        [1, 1, 1],
                                        [1, 1, 1]]).next_gen
  end

  def test_rectangle
    assert_equal [[1, 0, 0, 1],
                  [1, 0, 0, 1],
                  [0, 1, 1, 0]], Life.new([[1, 1, 1, 1],
                                           [1, 1, 1, 1],
                                           [0, 0, 0, 0]]).next_gen
  end

end