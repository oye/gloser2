class AssignmentsController < ApplicationController
  before_action :set_assignment_by_private_task_code, only: %i[ destroy edit update summary add_word ]
  before_action :set_assigment_by_public_task_code, only: %i[new_run create_run level_one level_one_answer level_others level_others_answer completed next_step]

  def new_run
  end

  def new_run_from_welcome
    if Assignment.exists?(public_task_code: params[:public_task_code])
      redirect_to new_run_path(public_task_code: params[:public_task_code])
    else
      flash[:warning] = "Ugyldig kode"
      redirect_to root_path
    end
  end

  def create_run
    session[:selected_levels] = params[:selected_levels].sort
    session[:current_step] = 0
    session[:total_steps] = @assignment.words.count * session[:selected_levels].count
    session[:score] = 0
    session[:current_level] = nil
    session[:current_word_id] = nil
    session[:available_word_ids] = nil
    proceed_and_redirect
  end

  def level_one
    @current_word = @assignment.words.find_by(id: session[:current_word_id])
    @word_completed = false
  end

  def level_one_answer
    process_answer
    render :level_one
  end

  def level_others
    @current_word = @assignment.words.find_by(id: session[:current_word_id])
    @word_completed = false
  end

  def level_others_answer
    process_answer
    render :level_others
  end

  def next_step
    proceed_and_redirect
  end

  def completed
  end

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

  def edit
  end

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

  def destroy
    @assignment.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Oppgave slettet." }
      format.json { head :no_content }
    end
  end

  private
  def process_answer
    @current_word = @assignment.words.find_by(id: session[:current_word_id])
    @word_completed = true
    @correct_answer = false
    @guess = params[:guess].delete(".").strip.downcase
    @correct_word = @current_word.send("#{session[:to_prefix]}_text").delete(".").strip.downcase
    if @guess == @correct_word
      session[:score] += 1
      @correct_answer = true
    end
  end
  def next_level
    session[:current_level] = session[:selected_levels].delete_at(0)
    session[:available_word_ids] = @assignment.word_ids.shuffle
  end

  def next_word
    session[:current_step] += 1
    session[:current_word_id] = session[:available_word_ids].delete_at(0)
    if [ true, false ].sample
      session[:from_prefix] = "original"
      session[:to_prefix] = "translated"
    else
      session[:from_prefix] = "translated"
      session[:to_prefix] = "original"
    end
  end

  def proceed_and_redirect
    next_level if session[:available_word_ids].nil? || session[:available_word_ids].empty?
    next_word
    if session[:current_level].nil?
      redirect_to completed_url(@assignment.public_task_code)
      return
    end
    if session[:current_level] == "1"
      session[:answer_order] = [ "#{session[:to_prefix]}_text", "#{session[:to_prefix]}_text_error1", "#{session[:to_prefix]}_text_error2", "#{session[:to_prefix]}_text_error3" ].shuffle
      redirect_to level_one_url(@assignment.public_task_code)
    else
      redirect_to level_others_url(@assignment.public_task_code)
    end
  end
  def clean_word(word)
    word.gsub(/[^a-zæøå0-9\s]/i, "").strip.downcase
  end
  def correct_guess?(guess, answer)
    guess.gsub(/[^a-zæøå0-9\s]/i, "") == answer.gsub(/[^a-zæøå0-9\s]/i, "")
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_assignment_by_private_task_code
    @assignment = Assignment.find_by(private_task_code: params[:private_task_code])
  end

  def set_assigment_by_public_task_code
    @assignment = Assignment.find_by(public_task_code: params[:public_task_code])
  end

  # Only allow a list of trusted parameters through.
  def assignment_params
    params.expect(assignment: [ :name, :wrong_translations, words_attributes: [ [ :id, :original_text, :translated_text, :original_text_error1, :original_text_error2, :original_text_error3, :translated_text_error1, :translated_text_error2, :translated_text_error3, :_destroy ] ] ])
  end
end
