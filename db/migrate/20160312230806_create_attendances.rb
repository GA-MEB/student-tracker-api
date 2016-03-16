class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.date :date
      t.integer :status
      t.timestamps null: false
    end
  end
end
