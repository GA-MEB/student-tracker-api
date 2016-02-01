class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.integer :cohort_number, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.timestamps null: false
    end
  end
end
