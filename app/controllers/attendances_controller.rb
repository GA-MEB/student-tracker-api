class AttendancesController < ApplicationController

  def index
    render json: attendances, root: 'attendances'
  end

  def show
    render json: attendances.find(params[:id]), root: 'attendance'
  end

  private
  def attendances
    Student.find(params[:student_id]).attendances
  end
  
end
