require ScriptPaths::MOTOR
require ScriptPaths::WEAPON
require ModulePaths::INPUT
require ModulePaths::MOTOR_MOVES

class Player
  attr_reader :x, :y, :turn_taken
  def initialize(
    player_image,
    start_point,
    weapon: Weapon.new,
    motor: Motor.new(self, Input)
  )
    @screen = Screen::SCREEN
    @image = player_image
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @motor = motor
    @weapon = weapon
    @next_move = MotorMoves::IDLE

    @turn_taken = false
    warp(start_point[:x], start_point[:y])
  end

  def update 
    run_motor
  end

  def take_turn
    @turn_taken = false
  end
  
  def run_motor
    @motor.run
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def idle
    @next_move = MotorMoves::IDLE
  end

  def turn_left
    return if @next_move == MotorMoves::TURN_LEFT
    @angle -= 90 
    @next_move = MotorMoves::TURN_LEFT
    @turn_taken = true
  end
  
  def turn_right
    return if @next_move == MotorMoves::TURN_RIGHT
    @angle += 90
    @next_move = MotorMoves::TURN_RIGHT
    @turn_taken = true
  end

  def fire
    @weapon.fire
  end
  
  def accelerate
    return if @next_move == MotorMoves::GO_STRAIGHT
    @x += Gosu.offset_x(@angle, 32)
    @y += Gosu.offset_y(@angle, 32) 
    @next_move = MotorMoves::GO_STRAIGHT
    move
    @turn_taken = true
  end

  def move
    @x %= @screen[:w]
    @y %= @screen[:h]
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
