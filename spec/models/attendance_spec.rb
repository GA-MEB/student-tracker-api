require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe 'validations: Attendance' do
    it "is valid with date and status" do
      attendance = Attendance.new(
        date: Date.today,
        status: 'present'
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
  end
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
end
