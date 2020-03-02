class Motor
  def initialize(vehicle, input)
    @vehicle = vehicle
    @input = input
  end

  def run
    for input in @input.GetInput
      case input
        when InputTypes::LEFT
          @vehicle.turn_left
        when InputTypes::RIGHT
          @vehicle.turn_right
        when InputTypes::UP
          @vehicle.accelerate
      end
    end
    @vehicle.move
  end

end
