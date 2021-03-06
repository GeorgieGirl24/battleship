require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/turn'
require './lib/game'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_it_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_it_has_attributes
    computer = Computer.new
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal 2, computer.ship_count
  end

  def test_it_can_place_a_cruiser
    # skip
    cells = []
    board = Board.new
    cell_1 = Cell.new("D1")
    cells << cell_1
    cell_2 = Cell.new("D2")
    cells << cell_2
    cell_3 = Cell.new("D3")
    cells << cell_3
    computer = Computer.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["D1","D2","D3"])
    assert_equal false, board.valid_placement?(cruiser, ["D1","D2"])
    assert_equal [cruiser, cruiser, cruiser], board.place(cruiser, ["D1", "D2", "D3"])
    refute_equal [cruiser, cruiser], board.place(cruiser, ["D1", "D2", "D3"])
    refute_equal [cruiser, cruiser, cruiser, cruiser], board.place(cruiser, ["D1", "D2", "D3"])
  end

  def test_it_can_place_a_submarine
    # skip
    cells = []
    board = Board.new
    cell_1 = Cell.new("C1")
    cells << cell_1
    cell_2 = Cell.new("C2")
    cells << cell_2

    computer = Computer.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.valid_placement?(submarine, ["C1","C2"])
    assert_equal false, board.valid_placement?(submarine, ["C1","C2", "C3"])
    assert_equal [submarine, submarine], board.place(submarine, ["C1","C2"])
    refute_equal [submarine, submarine, submarine], board.place(submarine, ["C1","C2"])
    refute_equal [submarine], board.place(submarine, ["C1","C2"])
  end


end
