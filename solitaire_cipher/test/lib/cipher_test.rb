require "minitest/autorun"
require_relative "../../lib/cipher.rb"
require_relative "../../lib/dealer.rb"

class CipherTest < Minitest::Test

  def setup
    @cipher = Cipher.new
  end

  def test_encryption
    string = "Code in Ruby, live longer!"
    encrypted = @cipher.encrypt(string)
    assert_equal("GLNCQMJAFFFVOMBJIYCB", encrypted)
  end

  def test_decryption
    string = "CLEPKHHNIYCFPWHFDFEH"
    decrypted = @cipher.decrypt(string)
    assert_equal("YOURCIPHERISWORKINGX", decrypted)
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

  def test_convert_to_nums
    group = [["A", "B", "C", "D", "E"]]
    convert = @cipher.send("convert_to_nums", group)
    assert_equal(1, convert.first.first)
    assert_equal(5, convert.last.last)
  end

  def test_adding_groups
    group1 = [1,5,3,18, 20]
    group2 = [5,8,25, 19,7]
    added = @cipher.send("add_groups", group1, group2)
    assert_equal(6,added.first)
    assert_equal(1, added.last)
  end

  def test_convert_to_chars
    array = [1,6,25, 13, 19]
    convert = @cipher.send("convert_to_chars", array)
    assert_equal("A", convert.first)
    assert_equal("S", convert.last)
  end

end
