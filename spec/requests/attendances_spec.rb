require 'rails_helper'

def attendances_params
  [
    { date: Date.parse('2016-03-10'), status: 'present' },
    { date: Date.parse('2016-03-11'), status: 'present' },
    { date: Date.parse('2016-03-12'), status: 'present' },
    { date: Date.parse('2016-03-13'), status: 'tardy' },
    { date: Date.parse('2016-03-14'), status: 'tardy' },
    { date: Date.parse('2016-03-15'), status: 'left early' },
    { date: Date.parse('2016-03-16'), status: 'absent' }
  ]
end

def attendance
  Attendance.last
end

def student_params
  {
    given_name: 'Bob',
    surname: 'Marley',
    student_id_number: 10
  }
end

def student
  Student.last
end

RSpec.describe "Attendances", type: :request do
  before(:all) do
    Student.create!(student_params)
    attendances_params.each do |params|
      student.attendances << Attendance.create(params)
    end
  end
  after(:all) do
    Student.delete_all
    Attendance.delete_all
  end

  describe "GET /students/:student_id/attendances" do
    it "retrieves all attendances associated with a given student" do
      get "/students/#{student.id}/attendances"
      expect(response).to be_success

      attendances_response = JSON.parse(response.body)
      expect(attendances_response['attendances'].length
        ).to eq(student.attendances.count)
    end
  end
end
