class StudentsController < ApplicationController
  def index
    render json: Student.all, root: 'students'
  end
  def show
    render json: Student.find(params[:id]), root: 'student'
  end
  def create
    if params[:cohort_id] && Cohort.find_by(id: params[:cohort_id])
      @student = Cohort.find(params[:cohort_id]).students.create(student_params)
    else
      @student = Student.create(student_params)
    end

    if @student.save
      render json: @student, status: :created, root: 'student'
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end
  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      render json: @student, root: 'student'
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    head :no_content
  end


  private
  def student_params
    params.require(:student).permit(
      [:given_name, :surname, :student_id_number]
    )
  end
end
