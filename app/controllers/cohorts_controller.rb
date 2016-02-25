class CohortsController < ApplicationController
  def index
    render json: Cohort.all, root: 'cohorts'
  end
  def show
    render json: Cohort.find(params[:id]), root: 'cohort'
  end
end
