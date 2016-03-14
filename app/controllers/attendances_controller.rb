class AttendancesController < ApplicationController
  before_action :set_student

  def index
    render json: @student.attendances, root: 'attendances'
  end

  def show
    render json: @student.attendances.find(params[:id]), root: 'attendance'
  end

  private
  def set_student
    @student = Student.find(params[:student_id])
  end
end
