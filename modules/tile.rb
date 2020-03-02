module Tile
  TILE_SIZE = {x: 32, y: 32}
  def Tile.tilescreen(image)
    x = 0
    while x < Screen::SCREEN[:w]
      y = 0
      while y < Screen::SCREEN[:h]
        image.draw(x, y, 0)
        y += TILE_SIZE[:y]
      end
      x += TILE_SIZE[:x]
    end
  end
end