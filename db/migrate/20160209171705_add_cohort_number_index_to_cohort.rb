class AddCohortNumberIndexToCohort < ActiveRecord::Migration
  def change
    add_index :cohorts, :cohort_number, unique: true
  end
end
