class Point
  attr_reader :x, :y, :data 
  def initialize(x, y, data)
    @x = x
    @y = y
    @data = data;
  end
end

class Rectangle
  attr_reader :x, :y, :w, :h
  def initialize(x, y, w, h)
    @x = x
    @y = y
    @w = w
    @h = h
  end

  def draw
    color = Gosu::Color::YELLOW
    z = 10
    Gosu::draw_line(@x, @y, color, @x, @y + @h, color, z)
    Gosu::draw_line(@x, @y + @h, color, @x + @w, @y + @h, color, z)
    Gosu::draw_line(@x + @w, @y + @h, color, @x + @w, @y, color, z)
    Gosu::draw_line(@x + @w, @y, color, @x, @y, color, z)
  end

  def contains(point)
    point.x > @x &&
    point.x < @x + @w &&
    point.y > @y &&
    point.y < @y + @h
  end
  
  def intersects(range)
    return !(range.x + range.w < @x ||  
    range.x > @x + @w ||
    range.y + range.h < @y ||
    range.y > @y + @h)
  end
end

class QuadTree
  attr_reader :points, :boundary, :divided
  def initialize(boundary, capacity = 4)
    @boundary = boundary
    @capacity = capacity
    @points = [];
    @divided = false
  end
  
  def subdivide
    ne = Rectangle.new(@boundary.x + @boundary.w/2, @boundary.y, @boundary.w/2, @boundary.h/2)
    @northeast = QuadTree.new(ne)
    nw = Rectangle.new(@boundary.x, @boundary.y, @boundary.w/2, @boundary.h/2)   
    @northwest = QuadTree.new(nw)
    se = Rectangle.new(@boundary.x + @boundary.w/2, @boundary.y + @boundary.h/2, @boundary.w/2, @boundary.h/2)
    @southeast = QuadTree.new(se)
    sw = Rectangle.new(@boundary.x, @boundary.y + @boundary.h/2, @boundary.w/2, @boundary.h/2)      
    @southwest = QuadTree.new(sw)
    @divided = true
  end

  def draw_rects
    if @divided
      @southeast.boundary.draw
      @southeast.draw_rects if @southeast.divided == true
      @northeast.boundary.draw
      @northeast.draw_rects if @northeast.divided == true
      @northwest.boundary.draw
      @northwest.draw_rects if @northwest.divided == true
      @southwest.boundary.draw
      @southwest.draw_rects if @southwest.divided == true
    end
  end

  def insert(point)
    return false if !@boundary.contains(point)
    if (@points.length < @capacity)
      @points.push(point)
      return true
    else
      if !@divided
        subdivide
      end
      return true if @northeast.insert(point)
      return true if @northwest.insert(point)     
      return true if @southeast.insert(point)     
      return true if @southwest.insert(point)
    end
  end

  def query(range, found = [])
    return found if !@boundary.intersects(range)
    for p in @points
      if range.contains(p)
        found.push(p)
      end
    end
    if @divided
      @northeast.query(range, found) 
      @northwest.query(range, found)
      @southeast.query(range, found)
      @southwest.query(range, found)
    end
    return found
  end

end
