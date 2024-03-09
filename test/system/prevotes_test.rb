require "application_system_test_case"

class PrevotesTest < ApplicationSystemTestCase
  setup do
    @prevote = prevotes(:one)
  end

  test "visiting the index" do
    visit prevotes_url
    assert_selector "h1", text: "Prevotes"
  end

  test "should create prevote" do
    visit prevotes_url
    click_on "New prevote"

    click_on "Create Prevote"

    assert_text "Prevote was successfully created"
    click_on "Back"
  end

  test "should update Prevote" do
    visit prevote_url(@prevote)
    click_on "Edit this prevote", match: :first

    click_on "Update Prevote"

    assert_text "Prevote was successfully updated"
    click_on "Back"
  end

  test "should destroy Prevote" do
    visit prevote_url(@prevote)
    click_on "Destroy this prevote", match: :first

    assert_text "Prevote was successfully destroyed"
  end
end
