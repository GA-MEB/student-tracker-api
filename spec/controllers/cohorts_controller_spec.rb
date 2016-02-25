require 'rails_helper'

def cohort_params
  {
    cohort_number: 10,
    start_date: '2016-01-19',
    end_date: '2016-04-08'
  }
end
def cohorts
  Cohort.all
end
def cohort
  Cohort.last
end

RSpec.describe CohortsController, type: :controller do
  before(:all) { Cohort.create!(cohort_params) }
  after(:all) { Cohort.delete_all }

  describe "GET #index" do
    before(:each) { get :index }
    it "is successful" do
      expect(response.status).to eq(200)
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "GET #show" do
    before(:each) { get :show, id: cohort.id }
    it "is successful" do
      expect(response.status).to eq(200)
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "POST #create" do
    # it "is successful"
    # it "renders a JSON response"
  end
  describe "PATCH #update" do
    # it "is successful"
    # it "renders a JSON response"
  end
  describe "DELETE #destroy" do
    # it "is successful and returns an empty response"
  end
end
