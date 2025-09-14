def solve(x1, y1, x2, y2, xtarget, ytarget)
  det = x1*y2 - y1*x2
  x, y = {
    (xtarget*y2 - ytarget * x2)/det,
    (ytarget*x1 - xtarget * y1) / det,
  }
  if x.round == x && y.round == y
    (3 * x + y).to_i128
  else
    0
  end
end

input = File.read("input.day13").scan(/\d+/).map &.[0].to_i

p input.in_slices_of(6).sum { |vs| solve(vs[0], vs[1], vs[2], vs[3], vs[4], vs[5]) }
p input.in_slices_of(6).sum { |vs| solve(vs[0], vs[1], vs[2], vs[3], 10000000000000 + vs[4], 10000000000000 + vs[5]) }
