
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
    next_board = @board.map { |row| row.map { |col| 0 }} # init a new board the same size as the existing

    @board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        score = 0

        if i - 1 >= 0
          score += @board[i - 1][j]
          score += @board[i - 1][j - 1] if j - 1 >= 0
          score += @board[i - 1][j + 1] if j + 1 < row.length
        end
        if i + 1 < @board.length
          score += @board[i + 1][j - 1] if j - 1 >= 0
          score += @board[i + 1][j]
          score += @board[i + 1][j + 1] if j + 1 < row.length
        end
        score += @board[i][j - 1] if j - 1 >= 0
        score += @board[i][j + 1] if j + 1 < row.length

        if score == 3 # reproduction
          next_board[i][j] = 1
        elsif @board[i][j] == 1 && score > 1 && score < 4 # survival
          next_board[i][j] = 1
        end
        # everything else, leave it dead
      end
    end

    @board = next_board
  end

  #
  # Convert a string containing multiple lines into an array rep of the board
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