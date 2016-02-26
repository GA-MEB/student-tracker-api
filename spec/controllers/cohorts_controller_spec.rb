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
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "GET #show" do
    before(:each) { get :show, id: cohort.id }
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "POST #create" do
    before(:each) do
      Cohort.delete_all
      post :create, cohort: cohort_params, format: :json
    end
    it "is successful" do
      expect(response).to be_successful
    end
    it "renders a JSON response" do
      expect(JSON.parse(response.body)).not_to be(nil)
    end
  end
  describe "PATCH #update" do
    def cohort_diff
      {
        start_date: '2016-01-26'
      }
    end

    before(:each) do
      patch :update, id: cohort.id, cohort: cohort_diff, format: :json
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
      delete :destroy, id: cohort.id
      expect(response).to be_successful
      expect(response.body).to be_empty
    end
  end
end
