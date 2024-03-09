require "application_system_test_case"

class YsTest < ApplicationSystemTestCase
  setup do
    @y = ys(:one)
  end

  test "visiting the index" do
    visit ys_url
    assert_selector "h1", text: "Ys"
  end

  test "should create y" do
    visit ys_url
    click_on "New y"

    fill_in "Name", with: @y.name
    click_on "Create Y"

    assert_text "Y was successfully created"
    click_on "Back"
  end

  test "should update Y" do
    visit y_url(@y)
    click_on "Edit this y", match: :first

    fill_in "Name", with: @y.name
    click_on "Update Y"

    assert_text "Y was successfully updated"
    click_on "Back"
  end

  test "should destroy Y" do
    visit y_url(@y)
    click_on "Destroy this y", match: :first

    assert_text "Y was successfully destroyed"
  end
end
