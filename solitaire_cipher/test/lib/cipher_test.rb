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
    assert_equal("string", test_string)
  end
end
