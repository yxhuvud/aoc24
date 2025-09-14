input = File.read("input.day14").scan(/-?\d+/).map &.[0].to_i

def solve(robots, maxx1, maxx2)
  quadrants = {
    0 => 0,
    1 => 0,
    2 => 0,
    3 => 0,
  }
  robots.each do |(x1, x2, v1, v2)|
    x = (x1 + v1 * 100) % maxx1
    y = (x2 + v2 * 100) % maxx2
    case {x <=> maxx1//2, y <=> maxx2//2}
    when {-1, -1} then quadrants[0] += 1
    when {-1, 1}  then quadrants[1] += 1
    when {1, -1}  then quadrants[2] += 1
    when {1, 1}   then quadrants[3] += 1
    else
    end
  end

  quadrants.values.reduce { |a, b| a * b }
end

robots = input.in_slices_of(4).to_a
p solve(robots, 101, 103)

# def solve2(robots, maxx1, maxx2, steps)
#   robots.each do |(x1, x2, v1, v2)|
#     x = (x1 + v1 * steps) % maxx1
#     y = (x2 + v2 * steps) % maxx2
#   end
# end

def variance_x(robots, max, steps)
  values = robots.map do |(x1, x2, v1, v2)|
    (x1 + v1 * steps) % max
  end
  mean = values.sum / values.size
  values.sum { |v| (mean - v)**2 } / values.size
end

def variance_y(robots, max, steps)
  values = robots.map do |(x1, x2, v1, v2)|
    (x2 + v2 * steps) % max
  end
  mean = values.sum / values.size
  values.sum { |v| (mean - v)**2 } / values.size
end

def finder(robots)
  var_x = 0.to(101).min_by { |steps| variance_x(robots, 101, steps) }
  var_y = 0.to(103).min_by { |steps| variance_y(robots, 103, steps) }
  (0..101*103).find! { |i| i % 101 == var_x && var_y == i % 103 }
end

p finder(robots)
