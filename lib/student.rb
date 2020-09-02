class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end

#   1. def self.create_table
# 2. sql = <<-SQL 
# 3. CREATE TABLE IF NOT EXISTS songs (
# 4. id INTEGER PRIMARY KEY,
# 5. name TEXT,
# 6. album TEXT
# 7. )
# 8. SQL
# 9. DB[:conn].execute(sql)
# 10. end

#   1. def save
# 2. sql = <<-SQL
# 3. INSERT INTO songs (name, album)
# 4. VALUES (?, ?)
# 5. SQL
# 6.  
# 7. DB[:conn].execute(sql, self.name, self.album)
# 8.  
# 9. end