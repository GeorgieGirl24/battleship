class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil? 
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
    @fired_upon = true
  end

  def render(visible=false)
    if !empty? && !fired_upon? && visible == true
      "S"
    elsif !empty? && ship.sunk? && fired_upon?
      "X"
    elsif !empty? && fired_upon?
      "H"
    elsif empty? && fired_upon?
      "M"
    elsif empty? || !fired_upon?
      "."
    end
  end
end
