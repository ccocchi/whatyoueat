module WhatYouEat
  class Compare
  
    # Calculate the Levenshtein distance between two strings +str1+ and +str2+.
    # +str1+ and +str2+ should be ASCII, UTF-8, or a one-byte-per character encoding such
    # as ISO-8859-*.
    #
    # The strings will be treated as UTF-8 if $KCODE is set appropriately (i.e. 'u').
    # Otherwise, the comparison will be performed byte-by-byte. There is no specific support 
    # for Shift-JIS or EUC strings.
    def self.distance(str1, str2)
      s = str1.unpack('U*')
      t = str2.unpack('U*')
      n = s.length
      m = t.length
      return m if (0 == n)
      return n if (0 == m)

      d = (0..m).to_a
      x = nil

      (0...n).each do |i|
        e = i+1
        (0...m).each do |j|
          cost = (s[i] == t[j]) ? 0 : 1
          x = [
            d[j+1] + 1, # insertion
            e + 1,      # deletion
            d[j] + cost # substitution
          ].min
          d[j] = e
          e = x
        end
        d[m] = x
      end

      return x
    end
  end
end