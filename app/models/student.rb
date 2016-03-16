class Student < ActiveRecord::Base
  validates_presence_of :given_name, :surname, :student_id_number
  validates :student_id_number,
    uniqueness: {message: "must be unique"},
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 100_000_000
    }

  belongs_to :cohort, inverse_of: :students
  has_many :attendances, inverse_of: :student, dependent: :destroy
end
