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

  describe "GET #show" do
    before(:each) { get :show, student_id: student.id, id: attendance.id }
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

end
