require ModulePaths::INPUT_TYPES
module AiInput
  # Hard Code Inputs for now
  def AiInput.GetInput
    [Get_action()]
  end

  def AiInput.Get_action
    return Get_rand_constant()
  end

  def AiInput.Get_rand_constant
    InputTypes::ACTIONS[rand(InputTypes::ACTIONS.count)]
  end

  def AiInput.Generate_action
  end

  def AiInput.Set_timer
  end
end