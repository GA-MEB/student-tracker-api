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

RSpec.describe AttendancesController, type: :controller do
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

  describe "GET #index" do
    before(:each) { get :index, student_id: student.id }
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end

  describe "POST #create" do
    before(:each) do
      Attendance.delete_all
      post :create, {
        attendance: attendances_params[-1],
        student_id: student.id
      }, format: :json
    end
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end

  describe "GET #show" do
    before(:each) { get :show, id: attendance.id }
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end

  describe "PATCH #update" do
    def attendance_diff
      {
        status: "left_early"
      }
    end

    before(:each) do
      patch :update, {
        attendance: attendance_diff,
        id: attendance.id
      }, format: :json
    end
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end

  describe "DELETE #destroy" do
    it "is successful and returns an empty response" do
      delete :destroy, id: attendance.id
      expect(response).to be_successful
      expect(response.body).to be_empty
    end
  end

end
