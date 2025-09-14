record(Pos, x : Int32, y : Int32) do
  def left(boxes, obstacles)
    cursor = y - 1
    loop do
      if obstacles.includes?(Pos.new(x, cursor))
        return self
      elsif boxes.includes?(Pos.new(x, cursor))
        cursor -= 1
      else
        if cursor != y - 1
          boxes.delete(Pos.new(x, y - 1))
          boxes << Pos.new(x, cursor)
        end
        return Pos.new(x, y - 1)
      end
    end
  end

  def right(boxes, obstacles)
    cursor = y + 1
    loop do
      if obstacles.includes?(Pos.new(x, cursor))
        return self
      elsif boxes.includes?(Pos.new(x, cursor))
        cursor += 1
      else
        if cursor != y + 1
          boxes.delete(Pos.new(x, y + 1))
          boxes << Pos.new(x, cursor)
        end
        return Pos.new(x, y + 1)
      end
    end
  end

  def down(boxes, obstacles)
    cursor = x + 1
    loop do
      if obstacles.includes?(Pos.new(cursor, y))
        return self
      elsif boxes.includes?(Pos.new(cursor, y))
        cursor += 1
      else
        if cursor != x + 1
          boxes.delete(Pos.new(x + 1, y))
          boxes << Pos.new(cursor, y)
        end
        return Pos.new(x + 1, y)
      end
    end
  end

  def up(boxes, obstacles)
    cursor = x - 1
    loop do
      if obstacles.includes?(Pos.new(cursor, y))
        return self
      elsif boxes.includes?(Pos.new(cursor, y))
        cursor -= 1
      else
        if cursor != x - 1
          boxes.delete(Pos.new(x - 1, y))
          boxes << Pos.new(cursor, y)
        end
        return Pos.new(x - 1, y)
      end
    end
  end

  def down2(boxes, obstacles)
    # cursor = x + 1
    # loop do
    #   if obstacles.includes?(Pos.new(cursor, y))
    #     return self
    #   elsif boxes.includes?(Pos.new(cursor, y))
    #     cursor += 1
    #   else
    #     if cursor != x + 1
    #       boxes.delete(Pos.new(x + 1, y))
    #       boxes << Pos.new(cursor, y)
    #     end
    #     return Pos.new(x + 1, y)
    #   end
    # end
  end

  def up2(boxes, obstacles)
    # cursor = x - 1
    # loop do
    #   if obstacles.includes?(Pos.new(cursor, y))
    #     return self
    #   elsif boxes.includes?(Pos.new(cursor, y))
    #     cursor -= 1
    #   else
    #     if cursor != x - 1
    #       boxes.delete(Pos.new(x - 1, y))
    #       boxes << Pos.new(cursor, y)
    #     end
    #     return Pos.new(x - 1, y)
    #   end
    # end
  end

  def left2(boxes, obstacles)
    cursor = y - 1
    loop do
      if obstacles.includes?(Pos.new(x, cursor - 1))
        return self
      elsif boxes.includes?(Pos.new(x, cursor-1))
        cursor -= 2
      else
        if cursor != y - 1
          boxes.delete(Pos.new(x, y - 1))
          boxes << Pos.new(x, cursor)
        end
        return Pos.new(x, y - 1)
      end
    end
  end

  def right2(boxes, obstacles)
    # cursor = y + 1
    # loop do
    #   if obstacles.includes?(Pos.new(x, cursor))
    #     return self
    #   elsif boxes.includes?(Pos.new(x, cursor))
    #     cursor += 1
    #   else
    #     if cursor != y + 1
    #       boxes.delete(Pos.new(x, y + 1))
    #       boxes << Pos.new(x, cursor)
    #     end
    #     return Pos.new(x, y + 1)
    #   end
    # end
  end
end

input = File.read_lines("input.day15").map &.chars

current = Pos.new(0, 0)
boxes = Set(Pos).new
obstacles = Set(Pos).new

big_boxes = Set(Pos).new
big_obstacles = Set(Pos).new
big_boxes2 = Set(Pos).new
big_obstacles2 = Set(Pos).new

50.times do |i|
  input[i].each_with_index do |char, j|
    case char
    when '@'
      current = Pos.new(i, j)
      start2 = Pos.new(i, 2*j)
    when 'O'
      boxes << Pos.new(i, j)
      boxes2 << Pos.new(i, 2*j)
    when '#'
      obstacles << Pos.new(i, j)
      obstacles2 << Pos.new(i, 2*j)
    end
  end
end

moves = input[51..].flatten

moves.reduce(current) do |current, move|
  case move
  when '<'
    current.left(boxes, obstacles)
  when '>'
    current.right(boxes, obstacles)
  when '^'
    current.up(boxes, obstacles)
  when 'v'
    current.down(boxes, obstacles)
  else raise "unreachable"
  end
end
p boxes.sum { |b| b.x * 100 + b.y }

current = start2
moves.reduce(current) do |current, move|
  case move
  when '<'
    current.left2(boxes, obstacles2)
  when '>'
    current.right2(boxes, obstacles2)
  when '^'
    current.up(boxes2, obstacles2)
  when 'v'
    current.down(boxes2, obstacles2)
  else raise "unreachable"
  end
end
p boxes2.sum { |b| b.x * 100 + b.y }
