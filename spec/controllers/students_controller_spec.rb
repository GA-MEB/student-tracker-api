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

RSpec.describe StudentsController, type: :controller do
  before(:all) do
    Student.destroy_all
    Cohort.destroy_all
    Student.create!(student_params)
    Cohort.create!(cohort_params)
  end

  describe "GET #index" do
    before(:each) { get :index }
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "GET #show" do
    before(:each) { get :show, id: student.id }
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "POST #create" do
    context "when a cohort is not specified" do
      before(:each) do
        Student.delete_all
        post :create, student: student_params, format: :json
      end
      it "is successful" do
        expect(response).to be_successful
      end
      it "renders a JSON response" do
        expect(JSON.parse(response.body)).not_to be(nil)
      end
    end
    context "when a cohort is specified" do
      before(:each) do
        Student.delete_all
        post :create, { student: student_params, cohort_id: cohort.id }, format: :json
      end
      it "is successful" do
        expect(response).to be_successful
      end
      it "renders a JSON response" do
        expect(JSON.parse(response.body)).not_to be(nil)
      end
    end
  end
  describe "PATCH #update" do
    def student_diff
      {
        given_name: 'Williard'
      }
    end

    before(:each) do
      patch :update, id: student.id, student: student_diff, format: :json
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
      delete :destroy, id: student.id
      expect(response).to be_successful
      expect(response.body).to be_empty
    end
  end
end
