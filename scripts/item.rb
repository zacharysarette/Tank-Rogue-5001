class Item
  def initialize(image, start_point)
    @image = image
    @x = @y
    warp(start_point[:x], start_point[:y])
  end

  def update 
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
