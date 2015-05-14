require "minitest/autorun"
require_relative "../../lib/deck.rb"

class DeckTest < Minitest::Test

  def test_create_deck
    deck = Deck.create_deck
    assert_equal(1, deck[0])
    assert_equal("B", deck[-1])
    assert_equal(54, deck.count)
  end

end

