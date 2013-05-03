class AddStudentTeacherTags < ActiveRecord::Migration
  def up
    student = Tag.new
    student.name = "Student"
    student.save

    teacher = Tag.new
    teacher.name = "Teacher"
    teacher.save
  end

  def down
    student = Tag.find_by_name("Student")
    student.destroy

    teacher = Tag.find_by_name("Teacher")
    teacher.destroy
  end
end
