class Dealer

  def self.move_a(deck)
    index = deck.find_index("A")
    move_down(index, deck)
  end

  def self.move_b(deck)
    2.times do 
      index = deck.find_index("B")
      move_down(index, deck)
    end
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
