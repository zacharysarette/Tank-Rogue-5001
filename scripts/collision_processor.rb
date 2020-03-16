class CollisionProcessor

  def initialize

  end

  def load_point(obj)
    pt = Point.new(obj.x, obj.y, obj)
    @qt.insert(pt)
    pt = Point.new(obj.x, obj.y + 32 , obj)
    @qt.insert(pt)   
    pt = Point.new(obj.x + 32 , obj.y, obj)
    @qt.insert(pt)
    pt = Point.new(obj.x + 32 , obj.y + 32, obj)
    @qt.insert(pt)
  end

  def load_quad_tree
    boundary = Rectangle.new(0, 0, Screen::SCREEN[:w], Screen::SCREEN[:h])
    @qt = QuadTree.new(boundary, Configs::QUAD_TREE_CAPACITY)
  end

  def draw_qt
    @qt.draw_rects
  end

  def check_collisions(obj)
    range = Rectangle.new(obj.x, obj.y, 32, 32)
    points = @qt.query(range)
    for point in points
      other = point.data
      if obj != other
        collision_data = obj.collision_object.intersects(other.collision_object)
        if collision_data != nil
          obj.collision_object.set_highlight
          obj.react_to_collision(collision_data)
        end
      end
    end
  end

end
