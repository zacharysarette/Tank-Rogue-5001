require ModulePaths::INPUT_TYPES
module Input
  # Hard Code Inputs for now
  def Input.GetInput
    inputs = []
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      inputs.push(InputTypes::LEFT)
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      inputs.push(InputTypes::RIGHT)
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_UP
      inputs.push(InputTypes::UP)
    end
    if Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_DOWN
      inputs.push(InputTypes::DOWN)
    end
    if Gosu.button_down? Gosu::KB_LEFT_CONTROL or Gosu::button_down? Gosu::GpButton0
      inputs.push(InputTypes::ACTION_A)
    end
    if Gosu.button_down? Gosu::KB_SPACE or Gosu::button_down? Gosu::GpButton1
      inputs.push(InputTypes::ACTION_B)
    end
    return inputs
  end
end