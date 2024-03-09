require "application_system_test_case"

class ProposersTest < ApplicationSystemTestCase
  setup do
    @proposer = proposers(:one)
  end

  test "visiting the index" do
    visit proposers_url
    assert_selector "h1", text: "Proposers"
  end

  test "should create proposer" do
    visit proposers_url
    click_on "New proposer"

    fill_in "Name", with: @proposer.name
    fill_in "Session", with: @proposer.session
    click_on "Create Proposer"

    assert_text "Proposer was successfully created"
    click_on "Back"
  end

  test "should update Proposer" do
    visit proposer_url(@proposer)
    click_on "Edit this proposer", match: :first

    fill_in "Name", with: @proposer.name
    fill_in "Session", with: @proposer.session
    click_on "Update Proposer"

    assert_text "Proposer was successfully updated"
    click_on "Back"
  end

  test "should destroy Proposer" do
    visit proposer_url(@proposer)
    click_on "Destroy this proposer", match: :first

    assert_text "Proposer was successfully destroyed"
  end
end
