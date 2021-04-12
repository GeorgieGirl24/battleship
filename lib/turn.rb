
class Turn
  attr_reader :computer, :user
  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def computer_set_up
    @computer.place_cruiser
    @computer.place_submarine
  end

  def user_set_up
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    @user.place_cruiser
    @user.place_submarine
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @user.board.render(true)
  end

  def user_shot #user_turn
    puts "Enter the coordinate for your shot: "
    print "> "
    loop do
      user_shot = gets.chomp.upcase
      if @computer.board.valid_coordinate?(user_shot) && !(@computer.board.cells[user_shot].fired_upon?)
        @computer.board.cells[user_shot].fire_upon
        puts "Your shot #{user_shot} was a #{shot_type(user_shot)}"
        break
      elsif @computer.board.valid_coordinate?(user_shot) && @computer.board.cells[user_shot].fired_upon?
        puts "You've already fired on that coordinate. Please try again."
      else
        puts "Please enter a valid coordinate."
        print "> "
      end
    end
  end

  def computer_shot
    loop do
      computer_shot = user.board.cells.keys.sample
      if @user.board.valid_coordinate?(computer_shot) && !(@user.board.cells[computer_shot].fired_upon?)
        @user.board.cells[computer_shot].fire_upon
        puts "My shot #{computer_shot} was a #{shot_type(computer_shot)}"
        break
      end
    end
  end

  def shot_type(shot)
    if @computer.board.cells[shot].render == "H" || @user.board.cells[shot].render == "H"
      "hit."
    elsif @computer.board.cells[shot].render == "X"
      "masterful shot. You sunk the ship!"
    elsif user.board.cells[shot].render == "X"
      "masterful shot. The ship is sunk!"
    elsif @computer.board.cells[shot].render == "M" || @user.board.cells[shot].render == "M"
      "miss."
    end
  end

  def evaluate_computer_ships
    if @computer.cruiser.sunk && @computer.submarine.sunk
      @computer.ship_count = 0
    end
  end

  def evaluate_user_ships
    if @user.cruiser.sunk && @user.submarine.sunk
      @user.ship_count = 0
    end
  end
end
