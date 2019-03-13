class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash.values[0]
    @location = student_hash.values[1]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute|
      if attribute[0] == :twitter
        @twitter = attribute[1] 
      elsif attribute[0] == :linkedin
        @linkedin = attribute[1]
      elsif attribute[0] == :github 
        @github = attribute[1] 
      elsif attribute[0] == :blog 
        @blog = attribute[1] 
      elsif attribute[0] == :profile_quote
        @profile_quote = attribute[1]
      elsif attribute[0] == :bio 
        @bio = attribute[1]
        # binding.pry
      end 
    end 
  end

  def self.all
    @@all
  end
end

