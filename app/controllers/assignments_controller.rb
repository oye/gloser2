class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show destroy edit update summary add_word ]
  before_action :set_assigment_by_public_task_code, only: %i[new_run create_run level_one level_one_answer level_others level_others_answer next_level completed]

  def new_run
  end

  def create_run
    # SESSION
    # Store selected levels
    # Keep track of current level
    # Keep track of score
    # Keep track of where we are in the assignment (words solved, words left)

    # Need to randomize order of words starting each level
    # Need to randoomize order of possible answers starting each word in level 1
    # Need to randomize translation order(to/from language) between eache word in all levels.

    session[:selected_levels] = params[:selected_levels].sort
    session[:current_step] = 0
    session[:total_steps] = @assignment.words.count * session[:selected_levels].count
    redirect_to next_level_url(@assignment.public_task_code)
  end

  def level_one
    @current_word = @assignment.words.find_by(id: session[:current_word_id])
  end

  def level_one_answer
  end

  def level_others
  end

  def level_others_answer
  end

  def next_level
    redirect_to completed_url(@assignment.public_task_code) if session[:selected_levels].empty?
    session[:current_step] += 1
    session[:current_level] = session[:selected_levels].delete_at(0)
    session[:available_word_ids] = @assignment.word_ids.shuffle
    session[:current_word_id] = session[:available_word_ids].delete_at(0)
    if [ true, false ].sample
      session[:from_prefix] = "original"
      session[:to_prefix] = "translated"
    else
      session[:from_prefix] = "translated"
      session[:to_prefix] = "original"
    end
    if session[:current_level] == "1"
      session[:answer_order] = [ "#{session[:to_prefix]}_text", "#{session[:to_prefix]}_text_error1", "#{session[:to_prefix]}_text_error2", "#{session[:to_prefix]}_text_error3" ].shuffle
      redirect_to level_one_url(@assignment.public_task_code)
    else
      redirect_to level_others_url(@assignment.public_task_code)
    end
  end

  def completed
  end

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

    def set_assigment_by_public_task_code
      @assignment = Assignment.find_by(public_task_code: params[:public_task_code])
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.expect(assignment: [ :name, :wrong_translations, words_attributes: [ [ :id, :original_text, :translated_text, :original_text_error1, :original_text_error2, :original_text_error3, :translated_text_error1, :translated_text_error2, :translated_text_error3, :_destroy ] ] ])
    end
end
