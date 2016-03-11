require 'csv'

namespace :db do
  namespace :fill do

    desc 'Fill the database with example data'
    task all: [:cohorts]

    desc 'Fill the cohorts table with example data'
    task cohorts: :environment do
      Cohort.transaction do
        CSV.foreach(Rails.root + 'data/cohort_dummy_data.csv',
                    headers: true) do |cohort_row|
          cohort = cohort_row.to_hash
          next if Cohort.exists? cohort
          Cohort.create!(cohort)
        end
      end
    end

  end
end
