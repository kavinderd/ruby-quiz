class Deck
  def self.create_deck
    @deck = (1..52).to_a + ["A"] + ["B"]  
  end

end
