class Student < ActiveRecord::Base
  validates_presence_of :given_name, :surname, :student_id_number
end
