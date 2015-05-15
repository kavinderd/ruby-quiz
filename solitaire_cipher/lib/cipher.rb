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
    unencrypted_group = group_into_fives(unencrypted_string)
    unencrypted_string = convert_to_num(string)
  end

  private

  def group_into_fives(string)
    array = string.chars.each_slice(5).to_a
    until array.last.count == 5
      array.last << "X"
    end
    array
  end

  def convert_to_num(string)
  end

  def strip_invalid_characters(string)
    string.gsub(/[^a-zA-Z]/, "").upcase
  end

  def generate_keystream(length)
    keystream = ""
    until keystream.length == length
      @deck = Dealer.move_a(@deck)
      @deck = Dealer.move_b(@deck)
      @deck = Dealer.triple_cut(@deck)
      @deck = Dealer.count_cut(@deck)
      letter = Dealer.keystream_letter(@deck)
      keystream += letter if letter
    end
    keystream
  end
end
