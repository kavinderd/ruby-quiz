require "minitest/autorun"
require_relative "../../lib/dealer.rb"
require_relative "../../lib/deck.rb"

class DealerTest < Minitest::Test

  def setup
    @deck = Deck.create_deck
  end
  
  def test_move_a_joker
    Dealer.move_a(@deck)
    assert_equal("A", @deck[-1])
    Dealer.move_a(@deck)
    assert_equal("A", @deck[1])
  end

  def test_move_b_joker
    Dealer.move_a(@deck)
    Dealer.move_b(@deck)
    assert_equal("B", @deck[1])
  end

end
