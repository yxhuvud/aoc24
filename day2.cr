def safe?(row)
  (row.each_cons_pair.all? { |a, b| a < b } ||
    row.each_cons_pair.all? { |a, b| a > b }) &&
    row.each_cons_pair.all? { |a, b| (1..3).includes?((a - b).abs) }
end

def with_deletions(row)
  yield(row[1..]) || (row.size - 1).times.any? { |i| yield(row[..(i)] + row[(i + 2)..]) }
end

input = File.read("input.day2").lines.map &.split.map &.to_i

puts "part1: %s" % input.count { |row| safe?(row) }
puts "part2: %s" % input.count { |row| with_deletions(row) { |r| safe?(r) } }
