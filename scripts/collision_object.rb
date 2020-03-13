require ModulePaths::COLLISIONS

class CollisionObject
  attr_reader :rect
  def update_rect(x:, y:)
    @rect = COLLISIONS::GetRect(x, y)
  end

  def intersects(other_collision_object)
    COLLISIONS::GetCollision(@rect, other_collision_object.rect)
  end
end
