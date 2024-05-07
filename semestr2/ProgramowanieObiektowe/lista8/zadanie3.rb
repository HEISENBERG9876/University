class WyrazenieONP
  def initialize(wyrazenie)
    @wyrazenie = wyrazenie
    @stos = []
  end

  def oblicz(zmienne)
    @wyrazenie.each do |element|

      if element.is_a?(Numeric)
        @stos.push(Float(element))

      elsif element.match?(/[a-zA-Z]/)
        if zmienne.has_key?(element)
          @stos.push(zmienne[element])
        else
          puts "Nieznana zmienna: #{element}"
          return nil
        end

      elsif element == '+'
        arg2 = @stos.pop
        arg1 = @stos.pop
        @stos.push(arg1 + arg2)

      elsif element == '-'
        arg2 = @stos.pop
        arg1 = @stos.pop
        @stos.push(arg1  - arg2)

      elsif element == '*'
        arg2 = @stos.pop
        arg1 = @stos.pop
        @stos.push(arg1 * arg2)

      elsif element == '/'
        arg2 = @stos.pop
        arg1 = @stos.pop

        if arg2 == 0
          puts "Dzielenie przez zero"
          return nil

        else
          @stos.push(arg1 / arg2)
        end

      else
        puts "Nieznany operator: #{element}"
        return nil
      end

      puts @stos.to_s
    end

    if @stos.size != 1
      puts "Nieprawidłowe wyrażenie ONP"
      return nil

    else
      return @stos.pop

    end
  end
end


#testy
wyrazenie1 = WyrazenieONP.new([2, 'b', '+', 'c', '*'])
puts "wyrazenie1"
puts wyrazenie1.oblicz({'a' => 2, 'b' => 3, 'c' => 4})
puts puts

wyrazenie2 = WyrazenieONP.new([1, 2, '+', 4, '*', 2, '+'])
puts "wyrazenie2"
puts wyrazenie2.oblicz({'a' => 2, 'b' => 3, 'c' => 4})
puts puts

wyrazenie3 = WyrazenieONP.new([1, 2, '/', 4, '+'])
puts "wyrazenie3"
puts wyrazenie3.oblicz({})
puts puts

wyrazenie4 = WyrazenieONP.new(['a', 0, '/', 4, '+'])
puts "wyrazenie4"
puts wyrazenie4.oblicz({'a' => 1})
puts puts

wyrazenie5 = WyrazenieONP.new(['a', 1, 1, '/', '+'])
puts "wyrazenie5"
puts wyrazenie5.oblicz({'a' => 1})
