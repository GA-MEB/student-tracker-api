class Cohort < ActiveRecord::Base
  attr_accessor :cohort_number, :start_date, :end_date
  validates :cohort_number, presence: true, numericality: {only_integer: true, message: "must be an integer"}
  validates :start_date, presence: true
  validates :end_date, presence: true
end
