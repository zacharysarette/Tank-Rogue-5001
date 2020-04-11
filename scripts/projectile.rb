class Projectile
  attr_reader :x, :y
  def initialize(x, y, angle, images)
    @images = images
    @x = x
    @y = y 
    @angle = angle
    @vel_x = @vel_y = 0.0 
    @index = 0
    @last_time = Gosu.milliseconds
    next_image
    Objects::OBJECTS.add(self)
  end
  
  def update
    next_image if Gosu.milliseconds - @last_time > 150 
  end
  
  def launch(x, y, angle)
    @x = x
    @y = y
    @angle = angle
  end

  def next_image
    @last_time = Gosu.milliseconds
    @index += 1
    @index = 0 if @index > @images.size - 1
    @image = @images[@index] 
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
