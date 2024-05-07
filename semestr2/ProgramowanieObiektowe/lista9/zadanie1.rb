class Function
  def initialize(block)
    @func = block
  end

  def value(x)
    @func.call(x)
  end

  #metoda rownego podzialu
  def zero(a, b, e)
    fa = value(a)
    fb = value(b)

    if fa * fb > 0
      return nil
    end

    while (b - a).abs > e
      c = (a + b) / 2.0
      fc = value(c)

      if fc == 0
        return c
      elsif fa * fc < 0
        b = c
        fb = fc
      else
        a = c
        fa = fc
      end
    end

    return (a + b) / 2.0
  end

  #tzw. "midpoint integration method"
  def field(a, b)
    num_of_intervals = 100000.0
    dx = (b - a) / num_of_intervals
    field_sum = 0.0

    (0...num_of_intervals).each do |interval|
      x = a + (interval + 0.5) * dx
      field_sum += dx * value(x)
    end

    return field_sum
  end

  def deriv(x)
    x_accuracy = 0.000001
    dx = 2 * x_accuracy
    dy = value(x + x_accuracy) - value(x - x_accuracy)
    return dy / dx
  end

end


my_proc = Proc.new{ |x| x*x*Math.sin(x) }
funkcja1 = Function.new(my_proc)

puts puts "Funkcja: f(x) = x*x*sin(x)."
puts "f(1):"
puts puts funkcja1.value(1)

puts "Miejsce zerowe pomiedzy 1 i 4, dokladnosc 0.01."
puts puts funkcja1.zero(1, 4, 0.01)

puts "pole, miedzy 1 i 2."
puts puts funkcja1.field(1, 2)

puts "pochodna w x = 5."
puts puts funkcja1.deriv(5)
