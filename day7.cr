def find(row, target, current = -1, value = target)
  return nil if value < 0
  return value == row[current] if current == -row.size

  div, rem = value.divmod(row[current])
  find(row, target, current &- 1, value &- row[current]) ||
    (rem == 0 && find(row, target, current &- 1, div))
end

def find_concat(row, target, current = -1, value = target)
  return nil if value < 0
  return value == row[current] if current == -row.size

  div, rem = value.divmod(row[current])
  splitted, can_split = split(value, row[current])
  find_concat(row, target, current &- 1, value &- row[current]) ||
    (rem == 0 && find_concat(row, target, current &- 1, div)) ||
    (can_split && find_concat(row, target, current &- 1, splitted))
end

def split(target, val)
  v = (target &- val)
  mul = 10
  while mul <= val
    mul &*= 10
  end
  res = v // mul
  {res, res &* mul == v}
end

input = File.read_lines("input.day7").map &.split(/:? /).map(&.to_i64)

puts "part1: %s" % input.sum(0i64) { |(result, *row)| find(row, result) ? result : 0 }
puts "part2: %s" % input.sum(0i64) { |(result, *row)| find_concat(row, result) ? result : 0 }
