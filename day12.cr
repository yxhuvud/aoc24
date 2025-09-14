# Slow, ugly. Bitfields?

def expand_each(current, input, visited, char)
  group = Set(Pos).new
  group << current

  queue = Deque{current}
  while current = queue.shift?
    current.neighbours.each do |p|
      if p.valid?(input) && p.char_at?(input, char) && !group.includes?(p)
        group << p
        visited << p
        queue << p
      end
    end
  end
  group
end

record(Pos, x : Int32, y : Int32) do
  def neighbours
    {
      Pos.new(x + 1, y),
      Pos.new(x - 1, y),
      Pos.new(x, y + 1),
      Pos.new(x, y - 1),
    }
  end

  def valid?(input)
    0 <= x < input.size && 0 <= y < input.first.size
  end

  def char_at?(input, char)
    input[x][y] == char
  end
end

def perimeter(g)
  g.sum { |p| 4 - p.neighbours.count { |px| g.includes?(px) } }
end

def sides(g)
  g.sum { |p|
    m = p.neighbours.map { |px| g.includes?(px) }
    case m
    when {true, true, true, true}
      (g.includes?(Pos.new(p.x - 1, p.y - 1)) ? 0 : 1) +
        (g.includes?(Pos.new(p.x + 1, p.y - 1)) ? 0 : 1) +
        (g.includes?(Pos.new(p.x - 1, p.y + 1)) ? 0 : 1) +
        (g.includes?(Pos.new(p.x + 1, p.y + 1)) ? 0 : 1)
    when {true, true, false, false} then 0
    when {false, false, true, true} then 0
    when {true, true, false, true}
      (g.includes?(Pos.new(p.x - 1, p.y - 1)) ? 0 : 1) + (g.includes?(Pos.new(p.x + 1, p.y - 1)) ? 0 : 1)
    when {true, true, true, false}
      (g.includes?(Pos.new(p.x - 1, p.y + 1)) ? 0 : 1) + (g.includes?(Pos.new(p.x + 1, p.y + 1)) ? 0 : 1)
    when {true, false, true, true}
      (g.includes?(Pos.new(p.x + 1, p.y - 1)) ? 0 : 1) + (g.includes?(Pos.new(p.x + 1, p.y + 1)) ? 0 : 1)
    when {false, true, true, true}
      (g.includes?(Pos.new(p.x - 1, p.y - 1)) ? 0 : 1) + (g.includes?(Pos.new(p.x - 1, p.y + 1)) ? 0 : 1)
    when {true, false, true, false}
      1 + (g.includes?(Pos.new(p.x + 1, p.y + 1)) ? 0 : 1)
    when {true, false, false, true}
      1 + +(g.includes?(Pos.new(p.x + 1, p.y - 1)) ? 0 : 1)
    when {false, true, true, false}
      1 + (g.includes?(Pos.new(p.x - 1, p.y + 1)) ? 0 : 1)
    when {false, true, false, true}
      1 + (g.includes?(Pos.new(p.x - 1, p.y - 1)) ? 0 : 1)
    when {true, false, false, false}  then 2
    when {false, true, false, false}  then 2
    when {false, false, true, false}  then 2
    when {false, false, false, true}  then 2
    when {false, false, false, false} then 4
    else
      raise "unreachable"
    end
  }
end

input = File.read_lines("input.day12").map &.chars

visited = Set(Pos).new
groups = Set(Set(Pos)).new

input.each_with_index do |row, i|
  row.each_with_index do |char, j|
    current = Pos.new(i, j)
    next if visited.includes?(current)

    groups << expand_each(current, input, visited, char)
  end
end

puts groups.sum { |g| g.size * perimeter(g) }

puts groups.sum { |g| g.size * sides(g) }
