require "minitest/autorun"
require_relative "../../lib/dealer.rb"
require_relative "../../lib/deck.rb"

class DealerTest < Minitest::Test

  def setup
    @deck = Deck.create_deck
  end
  
  def test_move_a_joker
    @deck = Dealer.move_a(@deck)
    assert_equal("A", @deck[-1])
    @deck = Dealer.move_a(@deck)
    assert_equal("A", @deck[1])
  end

  def test_move_b_joker
    @deck = Dealer.move_a(@deck)
    @deck = Dealer.move_b(@deck)
    assert_equal("B", @deck[1])
  end

  def test_triple_cut
    @deck = Dealer.move_a(@deck)
    @deck = Dealer.move_b(@deck)
    @deck = Dealer.triple_cut(@deck)
    assert_equal(1, @deck[-1])
    assert_equal("B", @deck[0])
  end

end
