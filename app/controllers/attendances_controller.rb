class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :update, :destroy]

  def index
    render json: attendances, root: 'attendances'
  end

  def create
    @attendance = attendances.create(attendance_params)
    if @attendance.save
      render json: @attendance, status: :created, root: 'attendance'
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @attendance, root: 'attendance'
  end

  def update
    if @attendance.update(attendance_params)
      render json: @attendance, root: 'attendance'
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance.destroy
    head :no_content
  end

  private
  def attendances
    Student.find(params[:student_id]).attendances
  end

  def attendance_params
    params.require(:attendance).permit(:date, :status, :student_id)
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

end
