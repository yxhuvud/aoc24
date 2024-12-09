record(Pos, x : Int32, y : Int32) do
  def -(other)
    Pos.new(x - other.x, y - other.y)
  end

  def +(other)
    Pos.new(x + other.x, y + other.y)
  end

  def inside?(input)
    0 <= x < input.size && 0 <= y < input[0].size
  end
end

def antinodes_for_pair(p1, p2, input)
  diff = (p1 - p2)

  n1 = p1 + diff
  n2 = p2 - diff

  yield n1 if n1.inside?(input)
  yield n2 if n2.inside?(input)
end

def repeating_antinodes_for_pair(p1, p2, input)
  diff = (p1 - p2)
  while p1.inside?(input)
    yield p1
    p1 = p1 + diff
  end

  while p2.inside?(input)
    yield p2
    p2 = p2 - diff
  end
end

input = File.read("input.day8").lines.map &.chars
grouped_by_freq = Hash(Char, Array(Pos)).new { |h, k| h[k] = Array(Pos).new }

input.each_with_index do |row, i|
  row.each_with_index do |char, j|
    grouped_by_freq[char] << Pos.new(i, j) unless char == '.'
  end
end

antinodes = Set(Pos).new
grouped_by_freq.each do |f, ps|
  ps.each_combination(2).each do |(p1, p2)|
    antinodes_for_pair(p1, p2, input) { |an| antinodes << an }
  end
end

puts "part1: %s" % antinodes.size

grouped_by_freq.each do |f, ps|
  ps.each_combination(2).each do |(p1, p2)|
    repeating_antinodes_for_pair(p1, p2, input) do |an|
      antinodes << an
    end
  end
end

puts "part2: %s" % antinodes.size
