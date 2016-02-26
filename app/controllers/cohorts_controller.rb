class CohortsController < ApplicationController
  def index
    render json: Cohort.all, root: 'cohorts'
  end
  def show
    render json: Cohort.find(params[:id]), root: 'cohort'
  end
  def create
    @cohort = Cohort.create(cohort_params)
    if @cohort.save
      render json: @cohort, status: :created, root: 'cohort'
    else
      render json: @cohort.errors, status: :unprocessable_entity
    end
  end
  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      render json: @cohort, root: 'cohort'
    else
      render json: @cohort.errors, status: :unprocessable_entity
    end
  end

  private
  def cohort_params
    params.require(:cohort).permit([:cohort_number, :start_date, :end_date])
  end
end
