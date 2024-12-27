require "application_system_test_case"

class AssignmentsTest < ApplicationSystemTestCase
  setup do
    @assignment = assignments(:one)
  end

  test "visiting the root" do
    visit root_url
    assert_selector "h1", text: "Gloser"
  end
  test "visiting the summary page" do
    visit assignment_summary_url(@assignment.private_task_code)
    assert_selector "h1", text: "Oppsummering av oppgave"
  end

  test "should create assignment" do
    visit root_url
    click_on "ny oppgave her"

    fill_in "Oppgavenavn", with: @assignment.name
    fill_in "Original tekst", with: @assignment.words.first.original_text
    fill_in "Oversatt tekst", with: @assignment.words.first.translated_text
    click_on "Lag Oppgave"

    assert_text "Oppgave opprettet."
  end

  test "should update Assignment" do
    visit edit_assignment_url(@assignment.private_task_code)

    fill_in "Oppgavenavn", with: @assignment.private_task_code
    click_on "Oppdater Oppgave"

    assert_text "Oppgave oppdatert."
  end

  test "should destroy Assignment" do
    visit assignment_summary_url(@assignment.private_task_code)
    accept_confirm do
      click_on "Slett"
    end

    assert_text "Oppgave slettet."
    assert_current_path root_path
  end
end
