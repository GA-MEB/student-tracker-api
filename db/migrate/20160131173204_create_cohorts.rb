class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.integer :cohort_number, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps null: false
    end

    add_index :cohorts, :cohort_number, unique: true
  end
end
