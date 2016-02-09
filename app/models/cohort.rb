class Cohort < ActiveRecord::Base
  validates :cohort_number, presence: true,
  uniqueness: {message: "must be unique"},
  numericality: {
    only_integer: true,
    greater_than: 0,
    message: "must be an integer greater than zero"
  }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
