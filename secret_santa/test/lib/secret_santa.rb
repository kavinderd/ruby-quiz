require "minitest/autorun"
require_relative "../../lib/secret_santa"

class SecretSantaTest < Minitest::Test

  def test_inputting_people
    santa = SecretSanta.new
    santa.add(first_name: "Luke", last_name: "Skywalker", email: "luke@theforce.net")
    assert_equal(1, santa.people.count)
    santa.add(first_name: "Han",last_name: "Solo", email: "han@nerfherder.com")
    assert_equal(2, santa.people.count)
  end
end
