class ObjectPool
  def initialize
    @objects = []
  end

  def add(object)
    @objects.push(object)
  end

  def remove_all
    @objects = []
  end

  def get
    @objects
  end
end
