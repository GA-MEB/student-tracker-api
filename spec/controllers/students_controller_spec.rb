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
  Student.first
end

RSpec.describe StudentsController, type: :controller do
  before(:all) { Student.create!(student_params) }
  after(:all) { Student.delete_all }

  describe "GET #index" do
    before(:each) { get :index }
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
end
