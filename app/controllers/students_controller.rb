class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @search_params = params[:search] || {}
    @students = Student.all

    # Filter by major
    @students = @students.where(major: @search_params[:major]) if @search_params[:major].present?

    # Additional filtering by graduation year
    if @search_params[:graduation_year].present?
      @students = @students.where("extract(year from expected_graduation_date) = ?", @search_params[:graduation_year])
    end

    # Sorting (by name or graduation date)
    if @search_params[:sort_by] == "name"
      @students = @students.order(:first_name, :last_name)
    elsif @search_params[:sort_by] == "graduation_date"
      @students = @students.order(:expected_graduation_date)
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        puts @student.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        puts @student.errors.full_messages
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :expected_graduation_date, :profile_picture)
    end
end
