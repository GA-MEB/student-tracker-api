class AddStudentRefToAttendances < ActiveRecord::Migration
  def change
    add_reference :attendances, :student, index: true
  end
end
