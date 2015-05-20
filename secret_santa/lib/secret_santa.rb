class Person < Struct.new(:first_name, :last_name, :email, :partner); end;
class SecretSanta

  attr_reader :people
  def initialize
    @people = []
    @assigned_people = []
  end

  def add(first_name:, last_name:,email:)
    @people << Person.new(first_name, last_name, email)
  end

end
