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
  it "is invalid with a non-unique student id number" do
    Student.create(
      given_name: 'Alvin',
      surname: 'Alberts',
      student_id_number: 230
    )
    duplicate_student_id_number = Student.new(
      given_name: 'Billy',
      surname: 'Boddy',
      student_id_number: 230
    )
    duplicate_student_id_number.valid?
    expect(duplicate_student_id_number.errors[:student_id_number]).to include(
      "must be unique"
    )
  end
  xit "is invalid with a negative student id number" do
    negative_student_id_number = Student.new(student_id_number: -100)
    negative_student_id_number.valid?
    expect(negative_student_id_number[:student_id_number]).to include(
      "can't be negative"
    )
  end
  xit "is invalid with a student id number over 100 million" do
    too_big_student_id_number = Student.new(student_id_number: 1000000000)
    too_big_student_id_number.valid?
    expect(too_big_student_id_number[:student_id_number]).to include(
      "can't be greater than 100 million"
    )
  end
end
