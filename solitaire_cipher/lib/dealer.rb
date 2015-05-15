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
    higher_joker = 0
    until is_joker?(deck[higher_joker])
      higher_joker += 1
    end
    lower_joker = deck.count - 1
    until is_joker?(deck[lower_joker])
      lower_joker -= 1
    end
    deck = deck[higher_joker..lower_joker] + deck[lower_joker..-1] + deck[0...higher_joker]
    deck
  end

  def self.count_cut(deck)
    bottom_val = deck[-1]
    removed = []
    bottom_val.times do
      removed << deck.shift
    end
    removed << bottom_val
    deck[-1..-1] = removed
    deck
  end

  def self.keystream_letter(deck)
    return if is_joker?(deck[0]) || is_joker?(deck[deck[0]])
    value = deck[deck[0]] 
    value -= 26 if value > 26  
    (value + 64).chr
  end

  def self.is_joker?(value)
    value == "A" || value == "B"
  end

  def self.move_down(index, deck)
    if index == deck.count - 1
      # End of Deck
      card = deck.pop
      top = deck.shift
      deck.unshift card
      deck.unshift top
    else
      deck[index], deck[index+1] = deck[index + 1], deck[index]
    end
  end
end
