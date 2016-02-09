require 'rails_helper'

RSpec.describe Student, type: :model do
  it "is valid with a given name, surname, and student id number" do
    student = Student.new(
      given_name: 'Charles',
      surname: 'Xavier',
      student_id_number: 10
    )
    expect(student).to be_valid
  end
  it "is invalid without a given name" do
    no_given_name = Student.new(given_name: nil)
    no_given_name.valid?
    expect(no_given_name.errors[:given_name]).to include("can't be blank")
  end
  it "is invalid without a surname" do
    no_surname = Student.new(surname: nil)
    no_surname.valid?
    expect(no_surname.errors[:surname]).to include("can't be blank")
  end
  it "is invalid without a student id number" do
    no_student_id_number = Student.new(student_id_number: nil)
    no_student_id_number.valid?
    expect(no_student_id_number.errors[:student_id_number]).to include(
      "can't be blank"
    )
  end
end
