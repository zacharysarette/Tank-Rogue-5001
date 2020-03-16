require ScriptPaths::MOTOR
require ScriptPaths::WEAPON
require ModulePaths::AI_INPUT
class Enemy
  attr_reader :x, :y, :collision_object
  def initialize(
    image,
    start_point,
    motor: Motor.new(self, AiInput),
    weapon: Weapon.new,
    collision_object: CollisionObject.new
    )
    @image = image
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @motor = motor
    @weapon = weapon 
    @collision_object = collision_object 
    @collision_object.update_rect(@x, @y)
    warp(start_point[:x], start_point[:y])
  end

  def update 
    run_motor
  end

  def react_to_collision(collision_data)
    return if collision_data == nil
    case collision_data
    when :left
      @vel_x = 2
    when :right
      @vel_x = 2
    when :top
      @vel_y = 2
    when :bottom
      @vel_y = 2
    end
    @motor.disable
    move
  end

  def run_motor
    @motor.run
  end

  def warp(x, y)
    @x, @y = x, y
    @collision_object.update_rect(@x, @y)
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
    @x %= Screen::SCREEN[:w] 
    @y %= Screen::SCREEN[:h]
    @collision_object.update_rect(@x, @y)   

    @vel_x *= 0.95
    @vel_y *= 0.95
    @motor.enable
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
