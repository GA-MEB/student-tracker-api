require 'rails_helper'

def cohorts
  Cohort.all
end

def cohort
  Cohort.first
end

RSpec.describe "Cohorts", type: :request do
  before(:all) { Cohort.create!(cohort_params) }
  after(:all) { Cohort.delete_all }

  describe "GET /cohorts" do
    it "gets all cohorts" do
      get '/cohorts'
      expect(response).to be_success

      cohorts_response = JSON.parse(response.body)
      expect(cohorts_response['cohorts'].length).to eq(cohorts.count)
    end
  end
  describe "GET /cohorts/:id" do
    it 'shows one cohort' do
      get "/cohorts/#{cohort.id}"
      expect(response).to be_success
      cohort_response = JSON.parse(response.body)
      expect(cohort_response['cohort']['id']).to eq(cohort.id)
      expect(cohort_response['cohort']['cohort_number']).to eq(
        cohort.cohort_number
      )
      expect(Date.parse(cohort_response['cohort']['start_date'])).to eq(
        cohort.start_date
      )
      expect(Date.parse(cohort_response['cohort']['end_date'])).to eq(
        cohort.end_date
      )
    end
  end
  xdescribe "POST /cohorts" do
    context "with valid attributes" do
      it "creates a new cohort" do
        post '/cohorts'
        expect(response).to be_success
        expect(response).to have_http_status(:created)
      end
    end
    context "with invalid attributes" do
      it 'is not successful' do
        expect(response).not_to be_success
      end
    end
  end
  xdescribe "PATCH /cohorts/:id" do
    context "with valid attributes" do
      it 'updates one cohort' do
        patch "/cohorts/#{cohort.id}"
        expect(response).to be_success
      end
    end
    context "with invalid attributes" do
      it "is unsuccessful" do
        expect(response).not_to be_success
      end
    end
  end
  xdescribe "DELETE /cohorts/:id" do
    it 'destroys one cohort' do
      delete "/cohorts/#{cohort.id}"
      expect(response).to be_success
      expect(response.body).to be_empty
    end
  end
end
