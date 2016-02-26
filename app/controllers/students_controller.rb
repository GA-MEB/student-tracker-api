class StudentsController < ApplicationController
  def index
    render json: Student.all, root: 'students'
  end
  def show
    render json: Student.find(params[:id]), root: 'student'
  end
end
