input = File.read_lines("input.day1").map &.split.map(&.to_i)
l, r = input.transpose
pairs = l.sort.zip(r.sort)
tally = r.tally

puts "part1: %s" % pairs.sum { |l, r| (l - r).abs }
puts "part2: %s" % l.sum { |l| tally.fetch(l, 0) * l }
