require "application_system_test_case"

class HierxesTest < ApplicationSystemTestCase
  setup do
    @hierx = hierxes(:one)
  end

  test "visiting the index" do
    visit hierxes_url
    assert_selector "h1", text: "Hierxes"
  end

  test "should create hierx" do
    visit hierxes_url
    click_on "New hierx"

    fill_in "Child", with: @hierx.child_id
    fill_in "Generaion", with: @hierx.generaion
    fill_in "Parent", with: @hierx.parent_id
    click_on "Create Hierx"

    assert_text "Hierx was successfully created"
    click_on "Back"
  end

  test "should update Hierx" do
    visit hierx_url(@hierx)
    click_on "Edit this hierx", match: :first

    fill_in "Child", with: @hierx.child_id
    fill_in "Generaion", with: @hierx.generaion
    fill_in "Parent", with: @hierx.parent_id
    click_on "Update Hierx"

    assert_text "Hierx was successfully updated"
    click_on "Back"
  end

  test "should destroy Hierx" do
    visit hierx_url(@hierx)
    click_on "Destroy this hierx", match: :first

    assert_text "Hierx was successfully destroyed"
  end
end
