class StudentsController < ApplicationController
  def index
    render json: Student.all, root: 'students'
  end
  def show
    render json: Student.find(params[:id]), root: 'student'
  end
  def create
    @student = Student.create(student_params)
    if @student.save
      render json: @student, status: :created, root: 'student'
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  private
  def student_params
    params.require(:student).permit(
      [:given_name, :surname, :student_id_number]
    )
  end
end
