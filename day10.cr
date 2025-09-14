input = File.read("input.day10").lines.map &.chars.map(&.to_s.to_i)

def within(input, i, j)
  0 <= i < input.size && 0 <= j < input[0].size
end

def neighbours(input, i, j)
  yield i + 1, j
  yield i - 1, j
  yield i, j + 1
  yield i, j - 1
end


trailheads = 0
input.each_with_index do |row, i|
  row.each_with_index do |char, j|
    next if char != 0

    trailheads += explore(input, i, j).size
  end
end

 p trailheads

def explore(input, i, j, current = 0)
  return Set{ {i, j} } if current == 9

  trailheads = Set(Tuple(Int32, Int32)).new
  neighbours(input, i, j) do |ii, jj|
    if within(input, ii, jj) && input[ii][jj] == current + 1
    #  p "exploring #{ii} #{jj} - #{current + 1}"
      trailheads = trailheads.concat(explore(input, ii, jj, current + 1))
    end
  end
  trailheads
end

trailheads = 0
input.each_with_index do |row, i|
  row.each_with_index do |char, j|
    next if char != 0
 #   p explore(input, i, j).size
    trailheads += explore2(input, i, j)
   # exit
  end
end

 p trailheads

def explore2(input, i, j, current = 0)
  return 1 if current == 9

  trailheads = 0
  neighbours(input, i, j) do |ii, jj|
    if within(input, ii, jj) && input[ii][jj] == current + 1
    #  p "exploring #{ii} #{jj} - #{current + 1}"
      trailheads += explore2(input, ii, jj, current + 1)
    end
  end
  trailheads
end
