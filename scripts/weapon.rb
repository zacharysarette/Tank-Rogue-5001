require ScriptPaths::PROJECTILE
class Weapon

  def initialize
    projectile_images = Gosu::Image::load_tiles(SpritePaths::PROJECTILES, 32, 32) 
    @active_projectile = Projectile.new(1000, 1000, 0.0, projectile_images)
  end

  def fire(x, y, angle)
    @active_projectile.launch(x, y, angle)
  end
end
