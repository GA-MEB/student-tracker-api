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
  it "is invalid with a zero or negative student id number" do
    zero_student_id_number = Student.new(student_id_number: 0)
    zero_student_id_number.valid?
    expect(zero_student_id_number.errors[:student_id_number]).to include(
      "must be greater than 0"
    )
    negative_student_id_number = Student.new(student_id_number: -100)
    negative_student_id_number.valid?
    expect(negative_student_id_number.errors[:student_id_number]).to include(
      "must be greater than 0"
    )
  end
  it "is invalid with a student id number over 100 million" do
    too_big_student_id_number = Student.new(student_id_number: 100_000_001)
    too_big_student_id_number.valid?
    expect(too_big_student_id_number.errors[:student_id_number]).to include(
      "must be less than or equal to 100000000" #100,000,000
    )
  end
end
