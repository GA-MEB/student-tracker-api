class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.date :date, null: false
      t.integer :status, null: false
      t.timestamps null: false
    end
  end
end
