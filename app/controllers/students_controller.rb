class StudentsController < ApplicationController
  def index
    render json: Student.all, root: 'students'
  end
end
