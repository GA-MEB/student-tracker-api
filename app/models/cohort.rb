class Cohort < ActiveRecord::Base
  validates :cohort_number, presence: true,
  uniqueness: {message: "must be unique"},
  numericality: {
    only_integer: true,
    greater_than: 0,
    message: "must be an integer greater than zero"
  }
  validates_presence_of :start_date, :end_date
end
