require 'zlib'

module Plantuml

  # converted from here https://github.com/dougn/python-plantuml/blob/master/plantuml.py

  # Encodes PlantUML text into encoded URL part.
  def self.encode(text)
    zlibbed = Zlib.deflate(text, 9)
    compressed = zlibbed[2..-4]
    return _ascii_encode(compressed)
  end

  def self._ascii_encode(data)
    res = ''
    (0...data.length).step(3).each do |i|
      if (i+2 == data.length)
        res += _encode3bytes(data[i].ord, data[i+1].ord, 0)
      elsif (i+1 == data.length)
        res += _encode3bytes(data[i].ord, 0, 0)
      else
        res += _encode3bytes(data[i].ord, data[i+1].ord, data[i+2].ord)
      end
    end
    return res
  end

  def self._encode3bytes(b1, b2, b3)
    c1 = b1 >> 2
    c2 = ((b1 & 0x3) << 4) | (b2 >> 4)
    c3 = ((b2 & 0xF) << 2) | (b3 >> 6)
    c4 = b3 & 0x3F
    res = ''
    res += _encode6bit(c1 & 0x3F)
    res += _encode6bit(c2 & 0x3F)
    res += _encode6bit(c3 & 0x3F)
    res += _encode6bit(c4 & 0x3F)
    return res
  end


  def self._encode6bit(b)
    if b < 10
      return (48 + b).chr
    end
    b -= 10
    if b < 26
      return (65 + b).chr
    end
    b -= 26
    if b < 26
      return (97 + b).chr;
    end
    b -= 26
    if b == 0
      return '-'
    end
    if b == 1
      return '_'
    end
    return '?'
  end

end
