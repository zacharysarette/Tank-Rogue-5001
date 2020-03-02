module MapGenerator

  def MapGenerator.CreateMap(dimensions, maxTunnels, maxLength)
    dimensions = dimensions
    maxTunnels = maxTunnels
    maxLength = maxLength
    map = MapGenerator.CreateArray(1, dimensions)
    currentRow = rand(1..dimensions - 1)
    currentColumn = rand(1..dimensions - 1)
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    lastDirection = []
    randomDirection = []

    while maxTunnels > 0 do

      # lets get a random direction - until it is a perpendicular to our lastDirection
      # if the last direction = left or right,
      # then our new direction has to be up or down,
      # and vice versa
      
      if lastDirection == []
        randomDirection = directions[rand(directions.count)]
      elsif lastDirection[1] == 0
          randomDirection = directions[rand(2..3)]
      else
        randomDirection = directions[rand(0..1)]
      end

      randomLength = rand(1..maxLength)
      tunnelLength = 0;

      #lets loop until our tunnel is long enough or until we hit an edge
      while tunnelLength < randomLength do
        if currentRow === 0
          if randomDirection[0] === -1 or randomDirection[1] === -1
            break
          end
        end
        if currentRow === dimensions - 1 
          if randomDirection[0] === 1 or randomDirection[1] === 1
            break
          end
        end

        #set the value of the index in map to 0 (a tunnel, making it one longer)
        map[currentRow][currentColumn] = 0
        #add the value from randomDirection to row and col (-1, 0, or 1) to update our location
        currentRow += randomDirection[0]
        currentColumn += randomDirection[1]
        #the tunnel is now one longer, so lets increment that variable
        tunnelLength += 1
      end

      if tunnelLength > 0 # update our variables unless our last loop broke before we made any part of a tunnel
        lastDirection = randomDirection; #/set lastDirection, so we can remember what way we went
        maxTunnels -= 1 # we created a whole tunnel so lets decrement how many we have left to create
      end

    end
    return map
  end

  def MapGenerator.CreateArray(num, dimensions)
    array = []
    i = 0
    dimensions.times {
      array.push([])
      dimensions.times {
        array[i].push(num)
      }
      i += 1
     }
    return array
  end

end
