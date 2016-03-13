class AttendancesController < ApplicationController
  before_action :ensure_valid_student_id

  def index
    render json: Student.find(params[:student_id]).attendances, root: 'attendances'
  end

  def ensure_valid_student_id
    unless Student.find_by(id: params[:student_id])
      render json: {error: 'invalid student id'}, status: 404
    end
  end
end
