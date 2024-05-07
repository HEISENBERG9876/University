key = {
  'a' => 'b',
  'b' => 'r',
  'r' => 'y',
  'y' => 'u',
  'u' => 'a'
  }


class Jawna
  def initialize(text)
    @text = text
  end

  def to_s
    @text
  end

  def zaszyfruj(key)
    Zaszyfrowane.new(@text.chars.map {|char| key[char]}.join)
  end
end


class Zaszyfrowane
  def initialize(text)
    @text = text
  end

  def to_s
    @text
  end

  def odszyfruj(key)
    Jawna.new(@text.chars.map {|char| key.invert[char]}.join)
  end
end


jawna = Jawna.new('ruby')
puts "Jawna wiadomość: #{jawna.to_s}"

zaszyfrowana = jawna.zaszyfruj(key)
puts "Zaszyfrowana wiadomość: #{zaszyfrowana.to_s}"

odszyfrowana = zaszyfrowana.odszyfruj(key)
puts "Odszyfrowana wiadomość: #{odszyfrowana.to_s}"
