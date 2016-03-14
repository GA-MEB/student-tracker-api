class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:update]

  def index
    render json: attendances, root: 'attendances'
  end

  def show
    render json: attendances.find(params[:id]), root: 'attendance'
  end

  def create
    @attendance = attendances.create(attendance_params)
    if @attendance.save
      render json: @attendance, status: :created, root: 'attendance'
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  def update
    if @attendance.update(attendance_params)
      render json: @attendance, root: 'attendance'
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

  def set_attendance
    @attendance = attendances.find(params[:id])
  end

end
