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
  validate :start_date_in_2012_or_later
  validate :start_and_end_on_weekdays
  validate :end_date_after_start_date
  validate :not_too_long

  private
  def start_date_and_end_date_are_dates
    errors.add(:start_date, "must be a date") unless start_date.is_a? Date
    errors.add(:end_date, "must be a date") unless end_date.is_a? Date
  end
  def start_date_in_2012_or_later
    if start_date && start_date < Date.parse('2012-01-01')
      errors.add(:start_date, "must not start before 2012")
    end
  end
  def start_and_end_on_weekdays
    if start_date && ([0,6].include? start_date.wday)
      errors.add(:start_date, "must not start on a weekend")
    end
    if end_date && ([0,6].include? end_date.wday)
      errors.add(:end_date, "must not end on a weekend")
    end
  end
  def end_date_after_start_date
    if start_date && end_date && (end_date - start_date < 1)
      errors.add(:end_date, "can't be on or before the start date")
    end
  end
  def not_too_long
    if start_date && end_date && (end_date - start_date > 120)
      errors.add(:end_date, "can't be more than 120 days after the start date")
    end
  end

end
