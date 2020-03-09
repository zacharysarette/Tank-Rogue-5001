class Point
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
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
  
  def contains(point)
    point.x >= @x - @w &&
    point.x <= @x + @w &&
    point.y >= @y - @h &&
    point.y <= @y + @h
  end
  
  def intersects(range)
    return range.x + range.width >= @x &&
    range.x <= @x + @w &&
    range.y + range.height >= @x &&
    range.y <= @y + @h
  end
end

class QuadTree
  def initialize(boundary, capacity = 4)
    @boundary = boundary
    @capacity = capacity
    @points = [];
    @divided = false
  end
  
  def subdivide
    ne = Rectangle.new(@boundary.x + @boundary.w/2, @boundary.y - @boundary.h/2, @boundary.w/2, @boundary.h/2)
    @northeast = QuadTree.new(ne)
    nw = Rectangle.new(@boundary.x - @boundary.w/2, @boundary.y - @boundary.h/2, @boundary.w/2, @boundary.h/2)   
    @northwest = QuadTree.new(nw)
    se = Rectangle.new(@boundary.x + @boundary.w/2, @boundary.y + @boundary.h/2, @boundary.w/2, @boundary.h/2)
    @southeast = QuadTree.new(se)
    sw = Rectangle.new(@boundary.x - @boundary.w/2, @boundary.y + @boundary.h/2, @boundary.w/2, @boundary.h/2)      
    @southwest = QuadTree.new(sw)
    @divided = true 
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
      @northwest.query(range, found)
      @northwest.query(range, found)
      @northwest.query(range, found)
      @northwest.query(range, found)
    end
    return found
  end

end
