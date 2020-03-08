require ScriptPaths::ENEMY
require ScriptPaths::ITEM
require ScriptPaths::WALL
require ModulePaths::MAP_GENERATOR

class Map
  def initialize
  end

  def generate(enemy_images, item_images, wall_images)
    generate_enemies(enemy_images)
    generate_items(item_images)
    generate_walls(wall_images)
  end

  def generate_enemies(images)
    rand(1..20).times{ generate_enemy(images[rand(images.count)])}
  end

  def generate_enemy(image)
    x = 32 * rand(16)
    y = 32 * rand(16)
    Objects::OBJECTS.add(Enemy.new(image, {x: x, y: y}))
  end

  def generate_items(images)
    rand(1..20).times{ generate_item(images[rand(images.count)])}
  end

  def generate_item(image)
    x = 32 * rand(16)
    y = 32 * rand(16)
    Objects::OBJECTS.add(Item.new(image, {x: x, y: y}))
  end

  def generate_walls(images)
    map = MapGenerator::CreateMap(24, 32, 60, 40)
    row = 0
    while row < map.count
      column = 0
      while column < map[0].count
        if map[row][column] != 0
          generate_wall(images[rand(images.count)], column, row)
        end
        column += 1
      end
      row += 1
    end
  end

  def generate_wall(image, row, column)
    x = 32 * row
    y = 32 * column
    Objects::OBJECTS.add(Item.new(image, {x: x, y: y}))
  end
end
