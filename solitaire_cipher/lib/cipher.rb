require_relative "dealer"
require_relative "deck"

class Cipher

  def initialize(deck=Deck.create_deck, dealer=Dealer.new)
    @deck = deck
    @dealer = dealer
  end

  def encrypt(string)
    unencrypted_string = strip_invalid_characters(string) 
    unencrypted_group = group_into_fives(unencrypted_string)

    keystream = generate_keystream(unencrypted_group.flatten.count)
    keystream_group = group_into_fives(keystream)

    unencrypted_nums = convert_to_nums(unencrypted_group)
    keystream_nums = convert_to_nums(keystream_group)

    added_array = add_groups(unencrypted_nums.flatten, keystream_nums.flatten)
    converted_array = convert_to_chars(added_array)
    converted_array.join("")
  end

  def decrypt(string)
    encrypted_string = string
    encrypted_group = group_into_fives(encrypted_string)

    keystream = generate_keystream(string.length)
    keystream_group = group_into_fives(keystream)

    encrypted_nums = convert_to_nums(encrypted_group)
    keystream_nums = convert_to_nums(keystream_group)

    diff_array = subtract_groups(encrypted_nums.flatten, keystream_nums.flatten)
    converted_array = convert_to_chars(diff_array)
    converted_array.join("")
  end

  private


  def convert_to_chars(array)
    array.map { |num| (num + 64).chr }
  end
  
  def add_groups(group1, group2)
    result = []
    group1.each_with_index do |num, index|
      value = num + group2[index]
      value -= 26 if value > 26
      result << value
    end
    result
  end

  def subtract_groups(group1, group2)
    result = []
    group1.each_with_index do |num, index|
      value = num - group2[index]
      value += 26 if num <= group2[index]
      result << value
    end
    result
  end

  def group_into_fives(string)
    array = string.chars.each_slice(5).to_a
    until array.last.count == 5
      array.last << "X"
    end
    array
  end

  def convert_to_nums(array_groups)
    result = []
    array_groups.each do |array|
      result << array.map { |item| item.ord - 64 }
    end
    result
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
