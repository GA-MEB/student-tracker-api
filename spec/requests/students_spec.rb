require 'rails_helper'

def students
  Student.all
end

def student
  Student.first
end

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "gets all students" do
      get '/students'
      expect(response).to be_success

      students_response = JSON.parse(response.body)
      expect(students_response.length).to eq(students.count)
      expect(response).to have_http_status(200)
    end
  end
  xdescribe "GET /students/:id" do
    it 'shows one student' do
      get "/students/#{student.id}"
      expect(response).to be_success
      student_response = JSON.parse(response.body)
      expect(student_response['student']['id']).to eq(student.id)
      expect(student_response['student']['student_id_number']).to eq(
        student.student_number
      )
      expect(student_response['student']['given_name']).to eq(
        student.given_name
      )
      expect(student_response['student']['surname']).to eq(
        student.surname
      )
    end
  end
  xdescribe "POST /students" do
    it "creates a new student" do
      post '/students'
      expect(response).to be_success
      expect(response).to have_http_status(:created)
    end
  end
  xdescribe "PATCH /students/:id" do
    it 'updates one student' do
      patch "/students/#{student.id}"
      expect(response).to be_success
    end
  end
  xdescribe "PUT /students/:id" do
    it 'updates one student' do
      put "/students/#{student.id}"
      expect(response).to be_success
    end
  end
  xdescribe "DELETE /students/:id" do
    it 'destroys one student' do
      delete "/students/#{student.id}"
      expect(response).to be_success
    end
  end
end
