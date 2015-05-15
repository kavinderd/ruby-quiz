require_relative "dealer"
require_relative "deck"

class Cipher

  def initialize(deck=Deck.create_deck, dealer=Dealer.new)
    @deck = deck
    @dealer = dealer
  end

  def encrypt(string)
    unencrypted_string = strip_invalid_characters(string) 
    keystream = generate_keystream(length)
  end

  private

  def strip_invalid_characters(string)
    string.gsub(/[^a-zA-Z]/, "")
  end

  def generate_keystream(length)
    @deck = Dealer.move_a(@deck)
    @deck = Dealer.move_b(@deck)
    @deck = Dealer.triple_cut(@deck)
    @deck = Dealer.count_cut(@deck)
    keystream = ""
    until keystream.length == length
      letter = Dealer.keystream_letter(@deck)
      keystream += letter if letter
    end
    keystream
  end
end
