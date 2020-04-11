require ScriptPaths::MOTOR
require ScriptPaths::WEAPON
require ModulePaths::AI_INPUT
require ModulePaths::MOTOR_MOVES

class Enemy
  attr_reader :x, :y, :turn_taken 
  def initialize(
    image,
    start_point,
    motor: Motor.new(self, AiInput),
    weapon: Weapon.new
    )
    @image = image
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @turn_taken = false
    @motor = motor
    @weapon = weapon 
    @new_move = MotorMoves::IDLE
    warp(start_point[:x], start_point[:y])
  end

  def update 
    if @turn_taken == false
      run_motor
    end
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
    @angle += 90.5
    @next_move = MotorMoves::TURN_RIGHT
    @turn_taken = true
  end

  def fire
    @weapon.fire(@x, @y, @angle)
    @turn_taken = true
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
    @turn_taken = true
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
