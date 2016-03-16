require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe 'associations: Attendance' do
    def students_association
      Attendance.reflect_on_association(:student)
    end

    it 'is associated with a Student' do
      expect(students_association).not_to be_nil
      expect(students_association.macro).to be(:belongs_to)
      expect(students_association.options[:inverse_of]).not_to be_nil
    end
  end
  describe 'validations: Attendance' do
    it "is valid with date and status" do
      a_student = Student.create({
        given_name: 'A',
        surname: 'Student',
        student_id_number: 2000
      })
      attendance = Attendance.new(
        date: Date.today,
        status: 'present',
        student_id: a_student.id
      )
      expect(attendance).to be_valid
    end
    it "is invalid without a date" do
      no_date = Attendance.new(date: nil)
      no_date.valid?
      expect(no_date.errors[:date]).to include("can't be blank")
    end
    it "is invalid without a status" do
      no_status = Attendance.new(status: nil)
      no_status.valid?
      expect(no_status.errors[:status]).to include("can't be blank")
    end
    it "is invalid without a student_id" do
      no_student_id = Attendance.new(student_id: nil)
      no_student_id.valid?
      expect(no_student_id.errors[:student_id]).to include("can't be blank")
    end
    it "is invalid with a date in the future" do
      future_date = Attendance.new(date: Date.today + 1)
      future_date.valid?
      expect(future_date.errors[:date]).to include("must not be a future date")
    end
    it "is invalid with a date that is a weekend" do
      weekend_date = Attendance.new(date: '2016-01-23')
      weekend_date.valid?
      expect(weekend_date.errors[:date]).to include("must not be a weekend")
    end
  end
end
