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

def cohort_params
  {
    cohort_number: 10,
    start_date: '2016-01-19',
    end_date: '2016-04-08'
  }
end

def cohort
  Cohort.last
end

RSpec.describe "Students", type: :request do
  before(:all) do
    Student.destroy_all
    Cohort.destroy_all
    Student.create!(student_params)
    Cohort.create!(cohort_params)
  end

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
  describe "PATCH /students/:id" do
    context "with valid attributes" do
      it 'updates one student' do
        new_values = {
          given_name: 'Eric',
          surname: 'Clapton',
          student_id_number: 200
        }
        patch "/students/#{student.id}", { student: new_values }
        expect(response).to be_success

        student_response = JSON.parse(response.body)
        expect(student_response['student']['given_name']
          ).to eq(new_values[:given_name])
        expect(student_response['student']['surname']
          ).to eq(new_values[:surname])
        expect(student_response['student']['student_id_number']
          ).to eq(new_values[:student_id_number])
      end
    end
    context "with invalid attributes" do
      it "is unsuccessful" do
        patch "/students/#{student.id}", {
          student: {
            given_name: nil
          }
        }
        expect(response).to_not be_success
        patch "/students/#{student.id}", {
          student: {
            surname: nil
          }
        }
        expect(response).to_not be_success
        patch "/students/#{student.id}", {
          student: {
            student_id_number: nil
          }
        }
        expect(response).to_not be_success
        patch "/students/#{student.id}", {
          student: {
            student_id_number: 0
          }
        }
        expect(response).to_not be_success
        patch "/students/#{student.id}", {
          student: {
            student_id_number: -1
          }
        }
        expect(response).to_not be_success
        patch "/students/#{student.id}", {
          student: {
            student_id_number: 100_000_001
          }
        }
        expect(response).to_not be_success
      end
    end
  end
  describe "DELETE /students/:id" do
    it 'destroys one student' do
      old_count = students.length

      delete "/students/#{student.id}"
      expect(response).to be_success
      expect(response.body).to be_empty
      expect(students.length - old_count).to eq(-1)
    end
  end

  ## Nested routes
  describe "POST /cohorts/:cohort_id/students" do
    context "with valid attributes" do
      context "and with a valid cohort id" do
        it "creates a new student associated with that cohort" do
          post "/cohorts/#{cohort.id}/students", {
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
          expect(student_response['student']['cohort_id']
            ).to eq(cohort.id)
        end
      end
      context "but with an invalid cohort id" do
        it "creates a new student not tied to any cohort" do
          invalid_cohort_id = 0
          post "/cohorts/#{invalid_cohort_id}/students", {
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
          expect(student_response['student']['cohort_id']
            ).to be_nil
        end
      end
    end
    context "with invalid attributes" do
      it "is not successful" do
        post "/cohorts/#{cohort.id}/students", {
          student: {
            given_name: nil,
            surname: nil,
            student_id_number: nil
          }
        }
        expect(response).to_not be_success
        post "/cohorts/#{cohort.id}/students", {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: -1
          }
        }
        expect(response).to_not be_success
        post "/cohorts/#{cohort.id}/students", {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: 0
          }
        }
        expect(response).to_not be_success
        post "/cohorts/#{cohort.id}/students", {
          student: {
            given_name: student_params[:given_name],
            surname: student_params[:surname],
            student_id_number: 200_000_000
          }
        }
        expect(response).to_not be_success
      end
    end
  end
  describe 'GET /cohorts:cohort_id/students' do
    context 'with a valid cohort id' do
      it 'gets all students in the specified cohort' do
        get "/cohorts/#{cohort.id}/students"
        expect(response).to be_success

        students_response = JSON.parse(response.body)
        expect(students_response['students'].length
          ).to eq(cohort.students.count)
      end
    end
    context 'with an invalid cohort id' do
      it 'is not successful' do
        invalid_cohort_id = 0
        get "/cohorts/#{invalid_cohort_id}/students"
        expect(response).to_not be_success
      end
    end
  end

end
