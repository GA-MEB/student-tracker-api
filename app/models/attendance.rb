class Attendance < ActiveRecord::Base
  enum status: [:present, :absent, :tardy, :left_early]

  validates_presence_of :date, :status, :student_id
  validate :date_is_not_future, :date_is_weekday

  belongs_to :student, inverse_of: :attendances

  private
  def date_is_not_future
    if date && date > Date.today
      errors.add(:date, "must not be a future date")
    end
  end
  def date_is_weekday
    if date && ([0,6].include? date.wday)
      errors.add(:date, "must not be a weekend")
    end
  end
end
