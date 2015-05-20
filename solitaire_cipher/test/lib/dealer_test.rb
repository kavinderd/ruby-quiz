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

  def test_count_cut
    @deck = Dealer.move_a(@deck)
    @deck = Dealer.move_b(@deck)
    @deck = Dealer.triple_cut(@deck)
    @deck = Dealer.count_cut(@deck)
    assert_equal(1, @deck[-1])
    assert_equal("B", @deck[-2])
    assert_equal(2, @deck[0])
  end

  def test_keystream_letter
    letters = []
    until letters.count == 6
      @deck = Dealer.move_a(@deck)
      @deck = Dealer.move_b(@deck)
      @deck = Dealer.triple_cut(@deck)
      @deck = Dealer.count_cut(@deck)
      letter = Dealer.keystream_letter(@deck)
      letters << letter if letter
    end
    assert_equal("D", letters[0])
    assert_equal("Y", letters[-1])
  end

end
