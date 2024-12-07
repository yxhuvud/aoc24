input = File.read("input.day5").lines
before = Array(Array(Bool)).new(size: 100) { Array(Bool).new(size: 100) { false } }
while (l = input.shift) && l != ""
  before[l[0..1].to_i][l[3..4].to_i] = true
end
updates = input.map &.split(',').map(&.to_i)
correct, incorrect = updates.partition { |row| row.each_cons(2).all? { |(a, b)| before[a][b] } }

puts "part1: %s" % correct.sum { |row| row[row.size // 2] }
puts "part2: %s" % incorrect.sum { |row| row.sort { |a, b| before[a][b] ? -1 : 1 }[row.size // 2] }
