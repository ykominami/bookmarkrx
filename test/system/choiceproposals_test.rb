require "application_system_test_case"

class ChoiceproposalsTest < ApplicationSystemTestCase
  setup do
    @choiceproposal = choiceproposals(:one)
  end

  test "visiting the index" do
    visit choiceproposals_url
    assert_selector "h1", text: "Choiceproposals"
  end

  test "should create choiceproposal" do
    visit choiceproposals_url
    click_on "New choiceproposal"

    fill_in "Content", with: @choiceproposal.content
    fill_in "Status", with: @choiceproposal.status
    click_on "Create Choiceproposal"

    assert_text "Choiceproposal was successfully created"
    click_on "Back"
  end

  test "should update Choiceproposal" do
    visit choiceproposal_url(@choiceproposal)
    click_on "Edit this choiceproposal", match: :first

    fill_in "Content", with: @choiceproposal.content
    fill_in "Status", with: @choiceproposal.status
    click_on "Update Choiceproposal"

    assert_text "Choiceproposal was successfully updated"
    click_on "Back"
  end

  test "should destroy Choiceproposal" do
    visit choiceproposal_url(@choiceproposal)
    click_on "Destroy this choiceproposal", match: :first

    assert_text "Choiceproposal was successfully destroyed"
  end
end
