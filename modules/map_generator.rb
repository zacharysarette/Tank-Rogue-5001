module MapGenerator

  def MapGenerator.CreateMap(rowsz, columnsz, maxTunnelsz, maxLengthz)
    rows = rowsz
    columns = columnsz
    maxTunnels = maxTunnelsz
    maxLength = maxLengthz
    map = CreateArray(1, rows, columns)
    currentRow = rand(rows)
    currentColumn = rand(columns)
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    lastDirection = []
    randomDirection = []

    while maxTunnels > 0 do

      # lets get a random direction - until it is a perpendicular to our lastDirection
      # if the last direction = left or right,
      # then our new direction has to be up or down,
      # and vice versa
      if lastDirection[1] == 0
        randomDirection = directions[rand(2..3)]
      else
        randomDirection = directions[rand(0..1)]
      end

      randomLength = rand(1..maxLength)
      tunnelLength = 0;

      #lets loop until our tunnel is long enough or until we hit an edge
      while tunnelLength < randomLength do
        #break the loop if it is going out of the map
  
        break if currentRow < 2 && randomDirection[1] === -1 
        break if currentRow >= map.count - 2 && randomDirection[1] === 1 
        break if currentColumn < 2 && randomDirection[0] === -1
        break if currentColumn >= map[0].count - 2 && randomDirection[0] === 1

        if map[currentRow][currentColumn] != 0
          map[currentRow][currentColumn] = 0
        end
        #set the value of the index in map to 0 (a tunnel, making it one longer)
        
        #add the value from randomDirection to row and col (-1, 0, or 1) to update our location

        #the tunnel is now one longer, so lets increment that variable
        tunnelLength += 1
        currentRow += randomDirection[1]
        currentColumn += randomDirection[0]
        
      end
      if tunnelLength > 0 # update our variables unless our last loop broke before we made any part of a tunnel
        lastDirection = randomDirection; #/set lastDirection, so we can remember what way we went
        maxTunnels -= 1 # we created a whole tunnel so lets decrement how many we have left to create
      end

    end
    return map
  end

  def MapGenerator.CreateArray(num, rows, columns)
    array = []

    rows.times do |i|
      array.push([])
      columns.times do
        array[i].push(i + 1)
      end
    end

    return array
  end

end
