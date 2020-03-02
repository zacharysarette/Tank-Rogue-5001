require ScriptPaths::MOTOR
require ScriptPaths::WEAPON
require ModulePaths::INPUT

class Player
  def initialize(player_image, start_point)
    @screen = Screen::SCREEN
    @image = player_image
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @motor = Motor.new(self, Input)
    @weapon = Weapon.new()
    warp(start_point[:x], start_point[:y])
  end

  def update 
    run_motor
  end

  def run_motor
    @motor.run
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 4.5
  end
  
  def turn_right
    @angle += 4.5
  end

  def fire
    @weapon.fire
  end
  
  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.5)
    @vel_y += Gosu.offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= @screen[:w] 
    @y %= @screen[:h]
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
