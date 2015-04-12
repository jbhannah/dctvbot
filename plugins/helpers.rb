# encoding: utf-8

module Plugins
  module Helpers

    def timeIsLink(time, includeDay=false, timezone='US/Eastern')
      time = time.in_time_zone(timezone)
      return "http://time.is/#{time.strftime("%H%M_%Z")}" unless includeDay
      return "http://time.is/#{time.strftime("%H%M_%d_%b_%Y_%Z")}"
    end

    def flipString(str)
      table ={
        "a" => [0x250].pack('U'),
        "A" => [0x2200].pack('U'),
        "b" => "q",
        "B" => [0x2107].pack('U'), #Could use better replacement (0x3BE)
        "c" => [0x254].pack('U'),
        "C" => [0x2183].pack('U'),
        "d" => "p",
        "D" => [0x25C3].pack('U'), #Could use better replacement; this triangle seems to combine with next char..
        "e" => [0x1DD].pack('U'),
        "E" => [0x18E].pack('U'),
        "f" => [0x25F].pack('U'),
        "F" => [0x2132].pack('U'),
        "g" => [0x183].pack('U'),
        "G" => [0x2141].pack('U'),
        "h" => [0x265].pack('U'),
        'H' => 'H',
        "i" => [0x131].pack('U'),
        'I' => 'I',
        "j" => [0x27E].pack('U'),
        "J" => [0x017F].pack('U'),
        "k" => [0x29E].pack('U'),
        # "l" => [0x283].pack('U'),
        "L" => [0x2142].pack('U'),
        "m" => [0x26F].pack('U'),
        'M' => 'W',
        "n" => "u",
        "N" => [0x1D0E].pack('U'),
        "p" => 'd',
        'q' => 'b',
        "r" => [0x279].pack('U'),
        "R" => [0x1D1A].pack('U'),
        "t" => [0x287].pack('U'),
        "T" => [0x22A5].pack('U'),
        "v" => [0x28C].pack('U'),
        "V" => [0x245].pack('U'),
        'u' => 'n',
        'U' => [0x22C2].pack('U'),
        "w" => [0x28D].pack('U'),
        "y" => [0x28E].pack('U'),
        'Y' => [0x2144].pack('U'),
        "." => [0x2D9].pack('U'),
        "[" => "]",
        "(" => ")",
        "{" => "}",
        "]" => "[",
        ")" => "(",
        "}" => "{",
        "?" => [0x0BF].pack('U'),
        "!" => [0x0A1].pack('U'),
        "'" => ",",
        '"' => [0x201E].pack('U'),
        "<" => ">",
        ">" => "<",
        "_" => [0x203E].pack('U'),
        '&' => [0x214B].pack('U'),
        [0x203F].pack('U') => [0x2040].pack('U'),
        [0x2045].pack('U') => [0x2046].pack('U'),
        [0x2234].pack('U') => [0x2235].pack('U'),
        "\r" => "\n",
      }
      text = str.chars.to_a
      revtext = []
      text.each do |char|
        if table.has_key?(char)
          revtext << table[char]
          next
        end
        if table.has_key?(char.downcase) #Fallback for lowercase characters.
          revtext << table[char.downcase]
          next
        end
        revtext << char
      end
      return revtext.reverse.join('').gsub(")-;","(-;").gsub(")-:","(-:").gsub(");","(;").gsub(");","(;").gsub("(-:",")-:").gsub("(:","):").gsub("#{table["D"]}:","#{table["D"]}-:")
    end

  end
end
