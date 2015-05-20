class Person < Struct.new(:first_name, :last_name, :email, :partner); end;
class SecretSanta
  ODD_NUMBER_ERROR = "Not an even number of people"

  attr_reader :people
  def initialize
    @people = []
    @assigned_people = []
  end

  def add(first_name:, last_name:,email:)
    @people << Person.new(first_name, last_name, email)
  end

  def process!
    return ODD_NUMBER_ERROR unless @people.count % 2 == 0
  end

end
