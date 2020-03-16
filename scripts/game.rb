require ModulePaths::CONFIGS
require ModulePaths::SCREEN
require ModulePaths::OBJECTS
require ModulePaths::COLLISIONS
require ScriptPaths::COLLISION_OBJECT
require ModulePaths::TILE
require ScriptPaths::COLLISION_PROCESSOR
require ScriptPaths::MAP
require ScriptPaths::PLAYER
require ScriptPaths::QUAD_TREE

class Game < Gosu::Window
  def initialize
    super Screen::SCREEN[:w], Screen::SCREEN[:h]
    self.caption = 'TANK ROGUE by Zach Sarette'
    @collision_processor = CollisionProcessor.new
    load_images
    @player = load_player
    generate_map
    load_objects
  end

  def load_images
    @background_image = Gosu::Image.new(SpritePaths::GRASS, :tileable => true)
    @tank_image = Gosu::Image.new(SpritePaths::TANK)
    @item_images = Gosu::Image::load_tiles(SpritePaths::ITEMS, 32, 32)
    #@projectile_images = Gosu::Image.new(SpritePaths::PROJECTILES, :tileable => true)
    @enemy_images = Gosu::Image::load_tiles(SpritePaths::ENEMIES, 32, 32)
    @wall_images = Gosu::Image::load_tiles(SpritePaths::WALLS, 32, 32)
  end

  def load_player
    Player.new(@tank_image, {x:40, y:40})
  end

  def generate_map
    @map = Map.new
    @map.generate(@enemy_images, @item_images, @wall_images)
  end

  def load_objects
    @objects = Objects::OBJECTS
    @objects.add(@player)
  end

  def update
    @collision_processor.load_quad_tree
    @objects.get.each{|obj|
      @collision_processor.load_point(obj)
      obj.update}
    @objects.get.each{|obj|
      @collision_processor.check_collisions(obj)}
  end

  def draw
    @objects.get.each{|obj| obj.draw}
    Tile::tilescreen(@background_image)
    @collision_processor.draw_qt
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

end
