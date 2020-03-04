module Collisions
  def Collisions.GetRect(x, y, image)
    return {
      :x => x,
      :y => y,
      :height => image.height,
      :width => image.width }
  end

  def Collisions.GetCollision(rect1, rect2)
    if Intersection(rect1, rect2)
      return :top if rect1[:y] >= rect2[:y] + rect2[:height]/2
      return :bottom if rect1[:y] <= rect2[:y] - rect2[:height]/2
      return :left if rect1[:x] > rect2[:x]
      :right
    end
    nil
  end

  def Collisions.Intersection(rect1, rect2)
    rect1[:x] + rect1[:width] >= rect2[:x] &&
    rect1[:x] <= rect2[:x] + rect2[:width] &&
    rect1[:y] + rect1[:height] >= rect2[:x] &&
    rect1[:y] <= rect2[:y] + rect2[:height]
  end
end
