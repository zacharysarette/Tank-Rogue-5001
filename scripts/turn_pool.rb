class TurnPool
  def initialize
    @turns = []
    @index = 0
  end

  def add(object)
    @turns.push(object)
  end

  def remove_all
    @turns = []
  end

  def get
    @turns
  end

  def get_current_turn_object
    @turns[@index]
  end

  def next_turn
    @turns[@index].take_turn
    @index += 1
    @index = 0 if @index > @turns.size - 1
  end
end

