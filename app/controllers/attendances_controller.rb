class AttendancesController < ApplicationController

  def index
    render json: attendances, root: 'attendances'
  end

  def show
    render json: attendances.find(params[:id]), root: 'attendance'
  end

  def create
    @attendance = Attendance.create(attendance_params)
    if @attendance.save
      render json: @attendance, status: :created, root: 'attendance'
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  private
  def attendances
    Student.find(params[:student_id]).attendances
  end

  def attendance_params
    params.require(:attendance).permit(:date, :status)
  end

end
