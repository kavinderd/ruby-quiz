require "minitest/autorun"
require_relative "../../lib/secret_santa"

class SecretSantaTest < Minitest::Test

  def setup
    @santa = SecretSanta.new
  end

  def test_inputting_people
    @santa = SecretSanta.new
    @santa.add(first_name: "Luke", last_name: "Skywalker", email: "luke@theforce.net")
    assert_equal(1, @santa.people.count)
    @santa.add(first_name: "Han",last_name: "Solo", email: "han@nerfherder.com")
    assert_equal(2, @santa.people.count)
  end

  def test_processing_people_odd_number
    @santa.add(first_name: "Luke", last_name: "Skywalker", email: "luke@theforce.net")
    assert_equal(SecretSanta::ODD_NUMBER_ERROR, @santa.process!)
  end

  def test_process_people_with_different_last_names
    @santa.add(first_name: "Luke", last_name: "Skywalker", email: "luke@theforce.net")
    @santa.add(first_name: "Han", last_name: "Solo", email: "han@nerfherder.com")
    @santa.add(first_name: "Lando", last_name: "Calrissian", email: "lando@cloudcity.gov")
    @santa.add(first_name: "Bail", last_name: "Organa", email: "bail@alderran.gov")
    @santa.process!
    assert_equal(0, @santa.people.count)
    assert_equal(2, @santa.assigned_pairs.count)
    assert_equal(2, @santa.assigned_pairs.first.count)
  end

  def test_process_people_with_similar_last_name
    @santa.add(first_name: "Luke", last_name: "Skywalker", email: "luke@theforce.net")
    @santa.add(first_name: "Han", last_name: "Solo", email: "han@nerfherder.com")
    @santa.add(first_name: "Lando", last_name: "Calrissian", email: "lando@cloudcity.gov")
    @santa.add(first_name: "Leia", last_name: "Skywalker", email: "bail@alderran.gov")
    @santa.process!
    @santa.assigned_pairs.each do |pair|
      refute_equal(pair.first.last_name,pair.last.last_name)
    end
  end

  def test_process_people_with_only_same_last_names
    @santa.add(first_name: "Luke", last_name: "Skywalker", email: "luke@theforce.net")
    @santa.add(first_name: "Leia", last_name: "Skywalker", email: "bail@alderran.gov")
    @santa.process!
    assert_equal(0, @santa.assigned_pairs.count)
    assert_equal(2, @santa.people.count)
    assert_equal(SecretSanta::SAME_LAST_NAME_ERROR, @santa.errors.first)
  end

end
