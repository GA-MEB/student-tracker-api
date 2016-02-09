class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :given_name, null: false
      t.string :surname, null: false
      t.integer :student_id_number, null: false
      t.timestamps null: false
    end
  end
end
