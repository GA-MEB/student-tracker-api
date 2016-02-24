class CohortsController < ApplicationController
  def index
    render json: Cohort.all
  end
end
