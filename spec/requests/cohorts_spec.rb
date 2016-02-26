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

RSpec.describe "Cohorts", type: :request do
  before(:all) { Cohort.create!(cohort_params) }
  after(:all) { Cohort.delete_all }

  describe "GET /cohorts" do
    it "gets all cohorts" do
      get '/cohorts'
      expect(response).to be_success

      cohorts_response = JSON.parse(response.body)
      expect(cohorts_response['cohorts'].length
        ).to eq(cohorts.count)
    end
  end
  describe "GET /cohorts/:id" do
    it 'shows one cohort' do
      get "/cohorts/#{cohort.id}"
      expect(response).to be_success
      cohort_response = JSON.parse(response.body)
      expect(cohort_response['cohort']['id']
        ).to eq(cohort.id)
      expect(cohort_response['cohort']['cohort_number']
        ).to eq(cohort.cohort_number)
      expect(Date.parse(cohort_response['cohort']['start_date'])
        ).to eq(cohort.start_date)
      expect(Date.parse(cohort_response['cohort']['end_date'])
        ).to eq(cohort.end_date)
    end
  end
  describe "POST /cohorts" do
    context "with valid attributes" do
      it "creates a new cohort" do
        post '/cohorts', {
          cohort: {
            cohort_number: 11,
            start_date: cohort_params[:start_date],
            end_date: cohort_params[:end_date]
          }
        }
        expect(response).to be_success
        expect(response).to have_http_status(:created)

        cohort_response = JSON.parse(response.body)
        expect(cohort_response['cohort']['id']
          ).not_to be_nil
        expect(cohort_response['cohort']['cohort_number']
          ).to eq(cohort.cohort_number)
        expect(Date.parse(cohort_response['cohort']['start_date'])
          ).to eq(cohort.start_date)
        expect(Date.parse(cohort_response['cohort']['end_date'])
          ).to eq(cohort.end_date)
      end
    end
    context "with invalid attributes" do
      it 'is not successful' do
        post '/cohorts', {
          cohort: {
            cohort_number: 0,
            start_date: cohort_params[:start_date],
            end_date: cohort_params[:end_date]
          }
        }
        expect(response).not_to be_success
        post '/cohorts', {
          cohort: {
            cohort_number: -1,
            start_date: cohort_params[:start_date],
            end_date: cohort_params[:end_date]
          }
        }
        expect(response).not_to be_success
        post '/cohorts', {
          cohort: {
            cohort_number: cohort_params[:cohort_number],
            start_date: '2016-01-17', # Sunday
            end_date: cohort_params[:end_date]
          }
        }
        expect(response).not_to be_success
        post '/cohorts', {
          cohort: {
            cohort_number: cohort_params[:cohort_number],
            start_date: cohort_params[:start_date],
            end_date: '2016-04-09' # Saturday
          }
        }
        expect(response).not_to be_success
      end
    end
  end
  describe "PATCH /cohorts/:id" do
    context "with valid attributes" do
      it 'updates one cohort' do
        new_values = {
          cohort: {
            cohort_number: 110,
            start_date: '2016-01-26',
            end_date: '2016-04-15'
          }
        }
        patch "/cohorts/#{cohort.id}", new_values
        expect(response).to be_success

        cohort_response = JSON.parse(response.body)
        expect(cohort_response['cohort']['cohort_number']
          ).to eq(new_values[:cohort][:cohort_number])
        expect(Date.parse(cohort_response['cohort']['start_date'])
          ).to eq(Date.parse(new_values[:cohort][:start_date]))
        expect(Date.parse(cohort_response['cohort']['end_date'])
          ).to eq(Date.parse(new_values[:cohort][:end_date]))
      end
    end
    context "with invalid attributes" do
      it "is unsuccessful" do
        patch "/cohorts/#{cohort.id}", {
          cohort: {
            cohort_number: 0
          }
        }
        expect(response).not_to be_success
        patch "/cohorts/#{cohort.id}", {
          cohort: {
            cohort_number: -1
          }
        }
        expect(response).not_to be_success
        patch "/cohorts/#{cohort.id}", {
          cohort: {
            start_date: '2016-01-17', # Sunday
          }
        }
        expect(response).not_to be_success
        patch "/cohorts/#{cohort.id}", {
          cohort: {
            end_date: '2016-04-09' # Saturday
          }
        }
        expect(response).not_to be_success
      end
    end
  end
  describe "DELETE /cohorts/:id" do
    it 'destroys one cohort' do
      old_count = cohorts.length

      delete "/cohorts/#{cohort.id}"
      expect(response).to be_success
      expect(response.body).to be_empty
      expect(cohorts.length - old_count).to eq(-1)
    end
  end
end
