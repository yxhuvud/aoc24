
# TODO: slow
input = File.read("input.day11").split.map(&.to_i64)

def split(s)
  {s[0..(s.size//2 - 1)].to_i64, s[s.size//2..].to_i64}
end

def add(alt_counts, v, count)
  alt_counts[v] = (alt_counts[v]? || 0i64) &+ count
end

def calculate_next(counts, alt_counts)
  counts.each do |v, count|
    vstr = v.to_s
    if v.zero?
      add(alt_counts, 1i64, count)
    elsif vstr.size.even?
      v1, v2 = split(vstr)
      add(alt_counts, v1, count)
      add(alt_counts, v2, count)
    else
      newv = v * 2024
      add(alt_counts, newv, count)
    end
  end
  counts.clear
  {counts, alt_counts}
end

counts = input.tally
counts = counts.transform_values &.to_i64
alt_counts = counts.dup
alt_counts.clear

25.times do |i|
  alt_counts, counts = calculate_next(counts, alt_counts)
end

p counts.values.sum

50.times do |i|
  alt_counts, counts = calculate_next(counts, alt_counts)
end

p counts.values.sum
