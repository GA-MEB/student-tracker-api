class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :given_name, null: false
      t.string :surname, null: false
      t.integer :student_id_number, null: false
      t.timestamps null: false
    end

    add_index :students, :student_id_number, unique: true
  end
end
