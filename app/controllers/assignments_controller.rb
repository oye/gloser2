class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show destroy edit update summary add_word ]

  # GET /assignments or /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1 or /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new(words: [ Word.new ])
  end

  def add_word
    @assignment = Assignment.new if @assignment.nil?
    @word = @assignment.words.build

    respond_to do |format|
      format.turbo_stream
    end
  end

  def summary
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments or /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to assignment_summary_path(@assignment.private_task_code), notice: "Oppgave opprettet." }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignment_summary_path(@assignment.private_task_code), notice: "Oppgave oppdatert." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy!

    respond_to do |format|
      format.html { redirect_to assignments_path, status: :see_other, notice: "Oppgave slettet." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = if params[:private_task_code]
        Assignment.find_by(private_task_code: params[:private_task_code])
      else
        Assignment.find_by(id: params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.expect(assignment: [ :name, :wrong_translations, words_attributes: [ [ :id, :original_text, :translated_text, :original_text_error1, :original_text_error2, :original_text_error3, :translated_text_error1, :translated_text_error2, :translated_text_error3, :_destroy ] ] ])
    end
end
