class Attendance < ActiveRecord::Base
  enum status: [:present, :absent, :tardy, :left_early]

  validates_presence_of :date, :status

  belongs_to :student, inverse_of: :attendances
end
