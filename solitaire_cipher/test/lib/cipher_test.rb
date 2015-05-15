require "minitest/autorun"
require_relative "../../lib/cipher.rb"
require_relative "../../lib/dealer.rb"

class CipherTest < Minitest::Test

  def setup
    @cipher = Cipher.new
  end

  # Private Method Tests

  def test_strip_invalid_chars
    test_string = "1 string!"
    test_string = @cipher.send("strip_invalid_characters", test_string)
    assert_equal("STRING", test_string)
  end

  def test_generate_keystream
    keystream = @cipher.send("generate_keystream", 5)
    assert_equal(5, keystream.length)
  end

  def test_group_into_fives
    string = "TESTSTRINGS"
    groups = @cipher.send("group_into_fives", string)
    assert_equal(3, groups.count)
    assert_equal("X", groups.last.last)
  end
end
