class Board
  attr_reader :rows, :cells, :columns
  def initialize
    @cells = make_cells
    @rows = rows
    @columns = columns
  end

  def make_board_size(board_size=4)
    # board_size = 4
    alphabet = ("A".."Z").to_a
    @rows = (1..(board_size)).to_a
    @columns = ("A"..alphabet[board_size -1]).to_a
    coordinates = @columns.map do |letter|
      @rows.map do |number|
        letter + number.to_s
      end
    end
    coordinates.flatten
  end

  def make_cells
    new_cells = {}
    make_board_size.map do |key|
      new_cells[key] = Cell.new(key)
    end
    new_cells
  end

  def valid_coordinate?(alphanumeric)
    @cells.keys.include?(alphanumeric)
  end

  def valid_placement?(ship_type, spots)
    not_overlapping?(spots) &&
    coordinate_equal?(ship_type, spots) &&
    (valid_numbers?(spots) || valid_letters?(spots))
  end

  def not_overlapping?(spots)
    spots.all? do |spot|
      @cells[spot].empty?
    end
  end

  def all_letters_same?(spots)
    find_letters(spots).uniq.length == 1
  end

  def all_numbers_same?(spots)
    find_digits(spots).uniq.length == 1
  end

  def coordinate_equal?(ship_type, spots)
    ship_type.length == spots.length
  end

  def find_digits(spots)
    spots.map do |spot|
      spot[1].to_i
    end
  end

  def find_letters(spots)
    spots.map do |spot|
      if spot.each_char != Integer
        spot.ord
      end
    end
  end

  def consecutive_numbers?(spots)
    set = @rows.each_cons(spots.length).to_a
    check = find_digits(spots).each_cons(spots.length).to_a
    set.any? do |group_element|
      group_element == check.flatten
    end
  end

  def consecutive_letters?(spots)
    set = make_letters_ord_numbers.each_cons(spots.length).to_a
    check = find_letters(spots).each_cons(spots.length).to_a
    set.any? do |group_element|
      group_element == check.flatten
    end
  end

  def make_letters_ord_numbers
    @columns.map do |letter|
      letter.ord
    end
  end

  def valid_numbers?(spots)
    consecutive_numbers?(spots) && all_letters_same?(spots)
  end

  def valid_letters?(spots)
    consecutive_letters?(spots) && all_numbers_same?(spots)
  end

  def place(ship_type, spots)
    placement = spots.map do |spot|
      @cells[spot].place_ship(ship_type)
    end
    placement
  end

  def render(visible=false)
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(visible)} #{@cells["A2"].render(visible)} #{@cells["A3"].render(visible)} #{@cells["A4"].render(visible)} \n" +
    "B #{@cells["B1"].render(visible)} #{@cells["B2"].render(visible)} #{@cells["B3"].render(visible)} #{@cells["B4"].render(visible)} \n" +
    "C #{@cells["C1"].render(visible)} #{@cells["C2"].render(visible)} #{@cells["C3"].render(visible)} #{@cells["C4"].render(visible)} \n" +
    "D #{@cells["D1"].render(visible)} #{@cells["D2"].render(visible)} #{@cells["D3"].render(visible)} #{@cells["D4"].render(visible)} \n"
  end
end
