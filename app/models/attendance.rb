class Attendance < ActiveRecord::Base
  enum status: [:present, :absent, :tardy, :left_early]

  validates_presence_of :date, :status
  validate :date_is_not_future

  belongs_to :student, inverse_of: :attendances

  private
  def date_is_not_future
    if date && date > Date.today
      errors.add(:date, "must not be a future date")
    end
  end
end
