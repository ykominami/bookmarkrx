require "application_system_test_case"

class PathxesTest < ApplicationSystemTestCase
  setup do
    @pathx = pathxes(:one)
  end

  test "visiting the index" do
    visit pathxes_url
    assert_selector "h1", text: "Pathxes"
  end

  test "should create pathx" do
    visit pathxes_url
    click_on "New pathx"

    fill_in "Idx", with: @pathx.idx
    fill_in "Last item", with: @pathx.last_item
    fill_in "Path", with: @pathx.path
    click_on "Create Pathx"

    assert_text "Pathx was successfully created"
    click_on "Back"
  end

  test "should update Pathx" do
    visit pathx_url(@pathx)
    click_on "Edit this pathx", match: :first

    fill_in "Idx", with: @pathx.idx
    fill_in "Last item", with: @pathx.last_item
    fill_in "Path", with: @pathx.path
    click_on "Update Pathx"

    assert_text "Pathx was successfully updated"
    click_on "Back"
  end

  test "should destroy Pathx" do
    visit pathx_url(@pathx)
    click_on "Destroy this pathx", match: :first

    assert_text "Pathx was successfully destroyed"
  end
end
