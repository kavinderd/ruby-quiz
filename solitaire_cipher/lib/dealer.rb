class Dealer

  def self.move_a(deck)
    index = deck.find_index("A")
    move_down(index, deck)
    deck
  end

  def self.move_b(deck)
    2.times do 
      index = deck.find_index("B")
      move_down(index, deck)
    end
    deck
  end

  def self.triple_cut(deck)
    b = deck.index("B")
    a = deck.index("A")

    a,b = b,a if a > b
    deck = deck[(b+1)..-1] + deck[a..b] + deck[0...a]
    deck
  end

  def self.count_cut(deck)
    last = deck[-1].to_i
    deck[-1..-1] = [deck[0...last], deck[-1]].flatten
    last.times { deck.shift }
    deck
  end

  def self.keystream_letter(deck)
    first= is_joker?(deck[0]) ? 53 : deck[0]
    value = deck[first]
    return if is_joker?(value)
    value -= 26 if value > 26  
    (value + 64).chr
  end

  def self.is_joker?(value)
    value == "A" || value == "B"
  end

  def self.move_down(index, deck)
    if index == deck.count - 1
      # End of Deck
      deck[1..1] = deck[index], deck[1]
      deck.pop
    else
      deck[index], deck[index+1] = deck[index + 1], deck[index]
    end
  end
end
