
class Life
  def initialize(board)
    if board.is_a? String
      @board = Life.parse_board(board)
    elsif board.is_a? Array
      @board = board
    else
      raise ArgumentError.new "bad board format"
    end
  end

  def current_board
    @board
  end

  def next_gen
    scores = @board.map { |row| row.map { |col| 0 }} # init an array of scores the same size as the board

    @board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        scores[i - 1][j]     += @board[i][j] if i - 1 >= 0
        scores[i - 1][j - 1] += @board[i][j] if i - 1 >= 0 && j - 1 >= 0
        scores[i][j - 1]     += @board[i][j] if j - 1 >= 0
        scores[i + 1][j - 1] += @board[i][j] if i + 1 < scores.length && j - 1 >= 0
        scores[i + 1][j]     += @board[i][j] if i + 1 < scores.length
        scores[i + 1][j + 1] += @board[i][j] if i + 1 < scores.length && j + 1 < scores[i].length
        scores[i][j + 1]     += @board[i][j] if j + 1 < scores[i].length
        scores[i - 1][j + 1] += @board[i][j] if i - 1 >= 0 && j + 1 < scores[i].length
      end
    end

    @board = scores.each_with_index.map do |row, i|
      row.each_with_index.map do |score, j|
        next 0 if score < 2 # under population
        next 1 if @board[i][j] == 1 && score > 1 && score < 4 # survival
        next 0 if score > 3 # overcrowding
        next 1 if score == 3 # reproduction
        next 0 # stay dead
      end
    end
  end

  #
  # Convert a string containing multiple lines into an array rep
  #
  def self.parse_board(input)
    board = []
    input.split(/\n/).each do |line|
      row = line.chars.reject { |c| c =~ /\s/ }.map do |c|
        next c.to_i if c == '0' || c == '1'
        raise ArgumentError.new "Invalid character in board: #{c}"
      end
      board << row
    end

    raise ArgumentError.new "Must be at least two rows on the board" if board.length < 2

    length = board[0].length
    board[1, board.length].each_with_index { |row, i| raise ArgumentError.new "Row #{i}'s length is not the same." if row.length != length }

    return board
  end
end