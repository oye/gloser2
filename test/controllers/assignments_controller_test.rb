require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assignment = assignments(:one)
  end

  test "should get new" do
    get new_assignment_url
    assert_response :success
  end

  test "should create assignment" do
    assert_difference("Assignment.count") do
      post assignments_url, params: { assignment: { name: "New assignment", wrong_translations: "0", words_attributes: [ { original_text: "Original text", translated_text: "Translated text" } ] } }
    end

    assert_redirected_to assignment_summary_url(Assignment.last.private_task_code, locale: I18n.locale)
  end

  test "should show assignment summary" do
    get assignment_summary_url(@assignment.private_task_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_assignment_url(@assignment.private_task_code)
    assert_response :success
  end

  test "should update assignment" do
    patch update_assignment_url(@assignment.private_task_code), params: { assignment: { name: "Updated assignment", wrong_translations: "0", words_attributes: [ { original_text: "New Original text", translated_text: "New Translated text" } ] } }
    assert_redirected_to assignment_summary_path(Assignment.last.private_task_code, locale: I18n.locale)
  end

  test "should destroy assignment" do
    assert_difference("Assignment.count", -1) do
      delete destroy_assignment_url(@assignment.private_task_code, locale: I18n.locale)
    end

    assert_redirected_to root_url(locale: I18n.locale)
  end

  test "should create run from welcome" do
    post new_run_from_welcome_url, params: { public_task_code: @assignment.public_task_code }
    assert_redirected_to new_run_path(public_task_code: @assignment.public_task_code)
  end

  test "should create run" do
    post create_run_url(@assignment.public_task_code), params: { selected_levels: [ "1", "2", "3" ] }
    assert_redirected_to level_one_url(@assignment.public_task_code, locale: I18n.locale)
  end

  test "should get level one" do
    post create_run_url(@assignment.public_task_code), params: { selected_levels: [ "1" ] }
    get level_one_url(@assignment.public_task_code)
    assert_response :success
  end

  test "should post level one answer" do
    post create_run_url(@assignment.public_task_code), params: { selected_levels: [ "1" ] }
    post level_one_answer_url(@assignment.public_task_code), params: { guess: "some guess" }
    assert_response :success
  end

  test "should get level others" do
    post create_run_url(@assignment.public_task_code), params: { selected_levels: [ "2" ] }
    get level_others_url(@assignment.public_task_code)
    assert_response :success
  end

  test "should post level others answer" do
    post create_run_url(@assignment.public_task_code), params: { selected_levels: [ "2" ] }
    post level_others_answer_url(@assignment.public_task_code), params: { guess: "some guess" }
    assert_response :success
  end

  test "should get next step" do
    post create_run_url(@assignment.public_task_code), params: { selected_levels: [ "1" ] }
    post level_one_answer_url(@assignment.public_task_code), params: { guess: "some guess" }
    get next_step_url(@assignment.public_task_code)
    assert_redirected_to completed_url(@assignment.public_task_code, locale: I18n.locale)
  end

  test "should add word" do
    get add_word_new_assignments_url(format: :turbo_stream)
    assert_response :success
  end
end
