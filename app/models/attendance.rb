class Attendance < ActiveRecord::Base
  enum status: [:present, :absent, :tardy, :left_early]

  belongs_to :student, inverse_of: :attendances
end
