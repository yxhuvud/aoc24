input = File.read("input.day3")

muls = input.scan(/mul\((\d+),(\d+)\)/).sum(0) do |m|
  m[1].to_i * m[2].to_i
end
puts "part1: %s" % muls

v = 0
d = true
input.scan(/do\(\)|don't\(\)|mul\((\d+),(\d+)\)/) do |m|
  if m[0] == "do()"
    d = true
  elsif m[0] == "don't()"
    d = false
  elsif !d
  else
    v += m[1].to_i * m[2].to_i
  end
end

puts "part2: %s" % v
