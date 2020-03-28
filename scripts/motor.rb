class Motor
  def initialize(vehicle, input)
    @vehicle = vehicle
    @input = input
    @motor_enabled = true
  end

  def disable
    @motor_enabled = false
  end
  
  def enable
    @motor_enabled = true
  end

  def run
    return if !@motor_enabled
    inputs = @input.GetInput
    @vehicle.idle if inputs == []
    for input in inputs
      case input
        when InputTypes::LEFT
          @vehicle.turn_left
        when InputTypes::RIGHT
          @vehicle.turn_right
        when InputTypes::UP
          @vehicle.accelerate
      end
    end

  end

end
