class Person < Struct.new(:first_name, :last_name, :email, :partner)
  def full_name
    first_name + " " + last_name
  end
end
class SecretSanta
  ODD_NUMBER_ERROR = "Not an even number of people"
  SAME_LAST_NAME_ERROR = "Remaining people have matching last names"

  attr_reader :people, :assigned_pairs, :errors
  def initialize
    @people = []
    @assigned_pairs = []
    @errors = []
  end

  def add(first_name:, last_name:,email:)
    @people << Person.new(first_name, last_name, email)
  end

  def process!
    return ODD_NUMBER_ERROR unless @people.count % 2 == 0
    while @people.any?
      person1 = @people.pop
      person2 = nil
      tried_indices = []
      until person2
        random_index = (0..(@people.count - 1)).to_a.sample
        break if tried_indices.count == @people.count
        if @people[random_index].last_name != person1.last_name
          person2 = @people.delete_at(random_index)
        end
        tried_indices << random_index
      end
      if person1 && person2
        @assigned_pairs << [person1, person2]
      else
        @people.push person1
        @errors << SAME_LAST_NAME_ERROR
        break
      end
    end
  end

  def print_santas
    @assigned_pairs.each do |pair|
      puts "Pair: #{pair.first.full_name} with #{pair.last.full_name}"
    end
  end

end
