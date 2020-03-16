require ModulePaths::COLLISIONS

class CollisionObject
  attr_reader :rect
  def update_rect(x, y)
    @rect = Collisions::GetRect(x, y)
  end

  def intersects(other_collision_object)
    Collisions::GetCollision(@rect, other_collision_object.rect)
  end
  
  def set_highlight
   # p "collided with: #{@rect}"
  end
end
