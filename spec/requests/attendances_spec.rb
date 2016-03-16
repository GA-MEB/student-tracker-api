require 'rails_helper'

def attendances_params
  [
    { date: Date.parse('2016-01-11'), status: 'present' },
    { date: Date.parse('2016-01-12'), status: 'present' },
    { date: Date.parse('2016-01-13'), status: 'present' },
    { date: Date.parse('2016-01-14'), status: 'tardy' },
    { date: Date.parse('2016-01-15'), status: 'tardy' },
    { date: Date.parse('2016-01-18'), status: 'left_early' },
    { date: Date.parse('2016-01-19'), status: 'absent' }
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

  describe "POST /students/:student_id/attendances" do
    context "with valid attributes" do
      it "creates a new attendance record for the given student" do
        post "/students/#{student.id}/attendances", {
          attendance: {
            date: (attendance.date + 1),
            status: 'present'
          }
        }
        expect(response).to be_success
        expect(response).to have_http_status(:created)

        attendance_response = JSON.parse(response.body)
        expect(attendance_response['attendance']['id']
          ).not_to be_nil
        expect(attendance_response['attendance']['student_id']
          ).to eq(student.id)
        expect(Date.parse(attendance_response['attendance']['date'])
          ).to eq(attendance.date)
        expect(attendance_response['attendance']['status']
          ).to eq(attendance.status)
      end
    end
    context "with invalid attributes" do
      it "is unsuccessful" do
        post "/students/#{student.id}/attendances", {
          attendance: {
            date: nil,
            status: 'present'
          }
        }
        expect(response).to_not be_success
        post "/students/#{student.id}/attendances", {
          attendance: {
            date: (attendance.date + 1),
            status: nil
          }
        }
        expect(response).to_not be_success
        future_date = Date.today() + 1
        post "/students/#{student.id}/attendances", {
          attendance: {
            date: future_date,
            status: 'present'
          }
        }
        expect(response).to_not be_success
        weekend_date = Date.parse('2016-03-13')
        post "/students/#{student.id}/attendances", {
          attendance: {
            date: weekend_date,
            status: 'present'
          }
        }
        expect(response).to_not be_success
      end
    end
  end

  describe "GET /attendances/:id" do
    it "retrieves the given attendance record" do
      get "/attendances/#{attendance.id}"
      expect(response).to be_success

      attendance_response = JSON.parse(response.body)
      expect(attendance_response['attendance']['id']
        ).to eq(attendance.id)
      expect(Date.parse(attendance_response['attendance']['date'])
        ).to eq(attendance.date)
      expect(attendance_response['attendance']['status']
        ).to eq(attendance.status)
    end
  end

  describe "PATCH /attendances/:id" do
    context "with valid attributes" do
      it 'updates one attendance record' do
        new_values = {
          date: attendance.date + 1,
          status: 'tardy'
        }
        patch "/attendances/#{attendance.id}", { attendance: new_values }
        expect(response).to be_success

        attendance_response = JSON.parse(response.body)
        expect(Date.parse(attendance_response['attendance']['date'])
          ).to eq(new_values[:date])
        expect(attendance_response['attendance']['status']
          ).to eq(new_values[:status])
      end
    end
    context "with invalid attributes" do
      it "is unsuccessful" do
        patch "/attendances/#{attendance.id}", {
          attendance: {
            date: nil,
            status: 'present'
          }
        }
        expect(response).to_not be_success
        patch "/attendances/#{attendance.id}", {
          attendance: {
            date: (attendance.date + 1),
            status: nil
          }
        }
        expect(response).to_not be_success
        future_date = Date.today() + 1
        patch "/attendances/#{attendance.id}", {
          attendance: {
            date: future_date,
            status: 'present'
          }
        }
        expect(response).to_not be_success
        weekend_date = Date.parse('2016-03-13')
        patch "/attendances/#{attendance.id}", {
          attendance: {
            date: weekend_date,
            status: 'present'
          }
        }
        expect(response).to_not be_success
        patch "/attendances/#{attendance.id}", {
          attendance: {
            date: attendance.date + 1,
            status: 'present',
            student_id: nil
          }
        }
        expect(response).to_not be_success
      end
    end
  end

  describe "DELETE /attendances/:id" do
    it 'destroys one attendance record' do
      old_count = student.attendances.length

      delete "/attendances/#{attendance.id}"
      expect(response).to be_success
      expect(response.body).to be_empty
      expect(student.attendances.length - old_count).to eq(-1)
    end
  end

end
