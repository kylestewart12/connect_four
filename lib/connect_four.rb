class ConnectFour
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new("x"), Player.new("o")]
  end

  def play
    puts "Welcome to Connect Four! Please don't sue us for trademark infringement."
    puts "The rules are simple. Players take turns dropping a piece onto the grid."
    puts "Victory occurs when a player has placed four pieces in a row vertically,"
    puts "horizontally, or diagonally."

    current_player = 0
    draw = false
    somebody_won = false
    until somebody_won or draw
      puts "Player #{current_player+1}\'s turn."
      @board.show
      @players[current_player].make_move(@board)

      @players.each_with_index do |p, i|
        if p.victory?(@board)
          @windex = i
          somebody_won = true
        end
      end
      if @board.full?
        draw = true
      end
      current_player = (current_player + 1)%2
    end
    @board.show
    if draw
      puts "Nobody wins, which means you both lose. Losers."
    else
      puts "The winner is player #{@windex + 1}"
    end
  end

end

class Board
  attr_accessor :squares

  def initialize
    @squares = Array.new(6){Array.new(7, "-")}
  end

  def show
    puts "\t" + "1 2 3 4 5 6 7"
    @squares.each do |row|
      print "\t"
      row.each do |sym|
        print sym, " "
      end
      puts
    end
  end

  def available?(column)
    @squares[0][column] == "-"
  end

  def full?
    @squares[0].all?{|x| x != "-"}
  end
end

class Player
  attr_reader :symbol

  def initialize(symbol="o")
    @symbol = symbol
  end

  def make_move(board)
    good_choice = false
    puts "Where do you want to play your piece?"
    until good_choice
      puts "Select a column # 1-7"
      choice = gets.chomp.to_i
      if choice < 1 or choice > 7
        puts "Come on, man, I said pick a # from 1-7." 
      elsif not board.available?(choice)
        puts "Sorry, that column is full! Choose another one."
      else
        good_choice = true
      end
    end
    if board.squares[5][choice-1] == "-"
      board.squares[5][choice-1] = @symbol
    else
      i = 0
      until board.squares[i][choice-1] != "-"
        i += 1
      end
      board.squares[i-1][choice-1] = @symbol
    end
  end

  def victory?(board)
    winner = false
    for i in 0..5
      for j in 0..3
        if board.squares[i][j]==@symbol and board.squares[i][j+1]==@symbol and 
            board.squares[i][j+2]==@symbol and board.squares[i][j+3]==@symbol
          winner = true
        end
      end
    end

    for j in 0..6
      for i in 0..2
        if board.squares[i][j]==@symbol and board.squares[i+1][j]==@symbol and
            board.squares[i+2][j]==@symbol and board.squares[i+3][j]==@symbol 
          winner = true
        end
      end
    end

    for i in 0..2
      for j in 0..3
        if board.squares[i][j]==@symbol and board.squares[i+1][j+1]==@symbol and
            board.squares[i+2][j+2]==@symbol and board.squares[i+3][j+3]==@symbol
          winner = true
        end
      end
      for j in 3..6
        if board.squares[i][j]==@symbol and board.squares[i+1][j-1]==@symbol and
            board.squares[i+2][j-2]==@symbol and board.squares[i+3][j-3]==@symbol
          winner = true
        end
      end
    end
    winner
  end

end

game = ConnectFour.new
game.play