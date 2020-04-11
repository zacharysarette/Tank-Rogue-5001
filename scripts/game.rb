require ModulePaths::CONFIGS
require ModulePaths::SCREEN
require ModulePaths::OBJECTS
require ModulePaths::TURNS
require ModulePaths::TILE
require ScriptPaths::MAP
require ScriptPaths::PLAYER

class Game < Gosu::Window
  def initialize
    super Screen::SCREEN[:w], Screen::SCREEN[:h]
    self.caption = 'TANK ROGUE by Zach Sarette'

    load_images
    @player = load_player
    load_turns
    load_objects
    generate_map
  end

  def load_images
    @background_image = Gosu::Image.new(SpritePaths::GRASS, :tileable => true)
    @tank_image = Gosu::Image.new(SpritePaths::TANK)
    @item_images = Gosu::Image::load_tiles(SpritePaths::ITEMS, 32, 32)
    @enemy_images = Gosu::Image::load_tiles(SpritePaths::ENEMIES, 32, 32)
    @wall_images = Gosu::Image::load_tiles(SpritePaths::WALLS, 32, 32)
  end

  def load_player
    Player.new(@tank_image, {x:48, y:48})
  end

  def generate_map
    @map = Map.new
    @map.generate(@enemy_images, @item_images, @wall_images)
  end

  def load_turns
    @turns = Turns::TURNS
    @turns.add(@player)
  end

  def load_objects
    @objects = Objects::OBJECTS
    @objects.add(@player)
  end

  def update
    @objects.get.each{|obj|
      obj.update}
    if @turns.get_current_turn_object.turn_taken == true 
      @turns.next_turn
    end
  end

  def draw
    @objects.get.each{|obj| obj.draw}
    Tile::tilescreen(@background_image)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

end
