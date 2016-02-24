class Student < ActiveRecord::Base
  validates_presence_of :given_name, :surname, :student_id_number
  validates :student_id_number,
    uniqueness: {message: "must be unique"},
    numericality: {
      only_integer: true,
      greater_than: 0
    }

end
