class Function
  def initialize(block)
    @func = block
  end

  def value(x, y)
    @func.call(x, y)
  end

  def volume(a, b, c, d)
    num_of_intervals = 1000.0
    dx = (b - a) / num_of_intervals
    dy = (d - c) / num_of_intervals
    volume_sum = 0.0

    #jak w z1- midpoint integration, ale dla funkcji dwoch zmiennych.
    (0...num_of_intervals).each do |interval_x|
      x = a + (interval_x + 0.5) * dx

      (0...num_of_intervals).each do |interval_y|
        y = c + (interval_y + 0.5) * dy

        volume_sum += dx * dy * value(x, y)
      end
    end

    return volume_sum
  end

  def contour_line(a, b, c, d, height)
    points = []
    step = 0.01
    accuracy = 0.001

    x = a
    while x <= b
      y = c
      while y <= d
        if (value(x, y) - height).abs <= accuracy
          points << [x, y]
        end
        y += step
      end
      x += step
    end

    return points
  end
end


my_proc = Proc.new{ |x, y| x*y*Math.sin(x * y) }

funkcja1 = Function.new(my_proc)


puts puts "Funkcja: f(x, y) = x*y*sin(x * y)."

puts "f(1, 1):"
puts puts funkcja1.value(1, 1)

puts "Objetosc dla (1, 2, 2, 10):"
puts puts funkcja1.volume(1, 2, 2, 10)

puts "Wartosci countour_line(0, 10, 0, 20, 2)."
puts puts funkcja1.contour_line(0, 10, 0, 20, 2)

puts "Sprawdzenie jednego z wynikow countor_line. ~2, zgadza sie."
puts puts funkcja1.value(1.340000000000001, 6.869999999999898)
