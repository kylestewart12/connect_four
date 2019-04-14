require "./lib/connect_four"

RSpec.describe Board do
  context "#initialize" do
    it "returns a 6 row, 7 column grid of dashes" do
      board = Board.new
      board.show
      expect(board.squares).to eq(Array.new(6){Array.new(7, "-")})
    end
  end
  context "#available" do
    it "checks if column has a free space for player move" do
      board = Board.new
      expect(board.available?(3)).to eq(true)
    end
  end
end

RSpec.describe Player do
  context "#initialize" do
    it "sets player symbol to 'x'" do
      plyr = Player.new("x")
      expect(plyr.symbol).to eq("x")
    end
  end

  context "#make_move" do
    it "prompts player to choose column in which to play piece" do
      plyr = Player.new("o")
      board = Board.new
      expect(plyr.make_move(board)).not_to be nil
    end
  end
end

RSpec.describe ConnectFour do
  context "#initialize" do
    it "makes the game board" do
      game = ConnectFour.new
      expect(game.board).not_to be nil
    end
  end
end

