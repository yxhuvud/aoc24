X = 'X'
M = 'M'
A = 'A'
S = 'S'

def mas(input, i, j, di, dj)
  return false unless 0 <= i + 3 * di < input.size
  return false unless 0 <= j + 3 * dj < input[1].size

  {input[i + di][j + dj], input[i + 2 * di][j + 2 * dj], input[i + 3 * di][j + 3 * dj]} == {M, A, S}
end

def cross(input, i, j)
  return false unless input[i][j] == A && 0 < i < input.size - 1 && 0 < j < input[0].size - 1

  {input[i - 1][j - 1], input[i + 1][j + 1], input[i - 1][j + 1], input[i + 1][j - 1]}.in?({
    {M, S, M, S},
    {S, M, M, S},
    {M, S, S, M},
    {S, M, S, M},
  })
end

input = File.read("input.day4").lines.map &.chars
count = input.each_with_index.sum do |row, i|
  row.each_index.sum do |j|
    next 0 unless input[i][j] == X

    {
      mas(input, i, j, -1, -1),
      mas(input, i, j, -1, 0),
      mas(input, i, j, -1, 1),
      mas(input, i, j, 0, -1),
      mas(input, i, j, 0, 1),
      mas(input, i, j, 1, -1),
      mas(input, i, j, 1, 0),
      mas(input, i, j, 1, 1),
    }.count(true)
  end
end
puts "part1: %s" % count

count = input.each_with_index.sum do |row, i|
  row.each_index.count { |j| cross(input, i, j) }
end

puts "part2: %s" % count
