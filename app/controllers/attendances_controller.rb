class AttendancesController < ApplicationController
  before_action :set_student

  def index
    render json: @student.attendances, root: 'attendances'
  end

  private
  def set_student
    @student = Student.find(params[:student_id])
  end
end
