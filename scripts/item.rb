class Item
  attr_reader :x, :y, :collision_object 
  def initialize(image, start_point, collision_object: CollisionObject.new)
    @image = image
    @x = @y
    @collision_object = collision_object 
    @collision_object.update_rect(@x, @y)
    warp(start_point[:x], start_point[:y])
  end

  def update 
  end

  def react_to_collision(collision_data)
  end

  def warp(x, y)
    @x, @y = x, y
    @collision_object.update_rect(@x, @y)
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
