# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

cohorts_csv = File.read(Rails.root.join('data', 'cohort_seeds.csv'))
CSV.parse(cohorts_csv, :headers => true).each do |row|
  Cohort.create(
    cohort_number: row['cohort_number'],
    start_date: row['start_date'],
    end_date: row['end_date']
  )
end
