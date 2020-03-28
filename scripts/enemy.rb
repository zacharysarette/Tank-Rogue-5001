require ScriptPaths::MOTOR
require ScriptPaths::WEAPON
require ModulePaths::AI_INPUT
require ModulePaths::MOTOR_MOVES

class Enemy
  attr_reader :x, :y 
  def initialize(
    image,
    start_point,
    motor: Motor.new(self, AiInput),
    weapon: Weapon.new
    )
    @image = image
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @motor = motor
    @weapon = weapon 
    @new_move = MotorMoves::IDLE
    warp(start_point[:x], start_point[:y])
  end

  def update 
  end

  def take_turn
    run_motor
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
  end

  def turn_right
    return if @next_move == MotorMoves::TURN_RIGHT
    @angle += 90.5
    @next_move = MotorMoves::TURN_RIGHT
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
  end

  def move
    @x %= Screen::SCREEN[:w] 
    @y %= Screen::SCREEN[:h]

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
