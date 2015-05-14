class Dealer

  def self.move_a(deck)
    index = deck.find_index("A")
    move_down(index, deck)
  end

  def self.move_down(index, deck)
    if index == deck.count - 1
      # End of Deck
      deck.unshift(deck.pop)
    else
      deck[index], deck[index+1] = deck[index + 1], deck[index]
    end
  end
end
