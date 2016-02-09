class Cohort < ActiveRecord::Base
  validates :cohort_number, presence: true,
  uniqueness: {message: "must be unique"},
  numericality: {
    only_integer: true,
    greater_than: 0,
    message: "must be an integer greater than zero"
  }
  validates_presence_of :start_date, :end_date
  validate :start_date_and_end_date_are_dates

  private
  def start_date_and_end_date_are_dates
    errors.add(:start_date, "must be a date") unless start_date.is_a? Date
    errors.add(:end_date, "must be a date") unless end_date.is_a? Date
  end
end
