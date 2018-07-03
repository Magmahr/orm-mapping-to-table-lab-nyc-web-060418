class Student

  attr_accessor :name, :grade
  attr_reader :id

hash

  def initialize(name,grade, id=nil)
    @name = name
    # @name = props[:name]
    @grade = grade
    # @grade = props[:grade]
    @id = id
  end

 def self.create_table
   sql = <<-SQL
   CREATE TABLE students (
     id INTEGER PRIMARY KEY,
     name TEXT,
     grade INTEGER
   )
   SQL

   DB[:conn].execute(sql)
 end

 def self.drop_table
   sql = <<-SQL
   DROP TABLE students
   SQL
   DB[:conn].execute(sql)
 end

 def save
   sql = <<-SQL
   INSERT INTO students (name, grade)
   VALUES ('#{@name}', '#{@grade}')
   SQL
   sql_select = <<-SQL
   SELECT last_insert_rowid()
   SQL
   DB[:conn].execute(sql)
   stand_in = DB[:conn].execute(sql_select).flatten
   @id = stand_in[0]
   Student.new(name, grade, id)
   # binding.pry
 end

 def self.create(name:, grade:)
   student = Student.new(name, grade)
   student.save
 end

end
