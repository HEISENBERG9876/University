class Function
  def initialize(block)
    @func = block
  end

  def value(x)
    @func.call(x)
  end

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

  def field(a, b)
    numOfIntervals = 100000.0
    dx = (b - a) / numOfIntervals
    fieldSum = 0.0

    (0...numOfIntervals).each do |interval|
      x = a + (interval + 0.5) * dx
      fieldSum += dx * value(x)
    end

    return fieldSum
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

funkcja1.ascii_draw(0, 100)
