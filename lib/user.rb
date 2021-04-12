class User
  attr_reader :board, :cruiser, :submarine
  attr_accessor :ship_count
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @ship_count = 2
  end

  def place_cruiser
    puts board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces): 🚢"
    print "> "
    loop do
      spots = gets.chomp.upcase.gsub(", ", " ").split
      if board.valid_placement?(cruiser, spots)
        board.place(cruiser, spots)
        puts "You did it! You're selection is valid!"
        break
      else
        puts "Invalid response. Please try again."
        print "> "
      end
    end
  end

  def place_submarine
    puts board.render(true)
    puts "Now enter the squares for the Submarine (2 spaces): ⛵️"
    print "> "
    loop do
      spots = gets.chomp.upcase.gsub(", ", " ").split
      if board.valid_placement?(submarine, spots)
        board.place(submarine, spots)
        puts "You did it! You're selection is valid!"
        break
      else
        puts "Invalid response. Please try again."
        print "> "
      end
    end
  end
end
