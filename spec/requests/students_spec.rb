require 'rails_helper'

def student_params
  {
    given_name: 'Bob',
    surname: 'Marley',
    student_id_number: 10
  }
end

def students
  Student.all
end

def student
  Student.last
end

RSpec.describe "Students", type: :request do
  before(:all) { Student.create!(student_params) }
  after(:all) { Student.delete_all }

  describe "GET /students" do
    it "gets all students" do
      get '/students'
      expect(response).to be_success

      students_response = JSON.parse(response.body)
      expect(students_response['students'].length
        ).to eq(students.count)
    end
  end
  describe "GET /students/:id" do
    it 'shows one student' do
      get "/students/#{student.id}"
      expect(response).to be_success
      student_response = JSON.parse(response.body)
      expect(student_response['student']['id']
        ).to eq(student.id)
      expect(student_response['student']['student_id_number']
        ).to eq(student.student_id_number)
      expect(student_response['student']['given_name']
        ).to eq(student.given_name)
      expect(student_response['student']['surname']
        ).to eq(student.surname)
    end
  end
  describe "POST /students" do
    context "with valid attributes" do
      it "creates a new student" do
        post '/students', {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: 11
          }
        }
        expect(response).to be_success
        expect(response).to have_http_status(:created)

        student_response = JSON.parse(response.body)
        expect(student_response['student']['id']
          ).not_to be_nil
        expect(student_response['student']['given_name']
          ).to eq(student.given_name)
        expect(student_response['student']['surname']
          ).to eq(student.surname)
        expect(student_response['student']['student_id_number']
          ).to eq(student.student_id_number)
      end
    end
    context "with invalid attributes" do
      it "is not successful" do
        post '/students', {
          student: {
            given_name: nil,
            surname: nil,
            student_id_number: nil
          }
        }
        expect(response).to_not be_success
        post '/students', {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: -1
          }
        }
        expect(response).to_not be_success
        post '/students', {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: 0
          }
        }
        expect(response).to_not be_success
        post '/students', {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: 2000
          }
        }
        post '/students', {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: 2000
          }
        }
        expect(response).to_not be_success
      end
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
