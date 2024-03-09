require "test_helper"

class HierxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hierx = hierxes(:one)
  end

  test "should get index" do
    get hierxes_url
    assert_response :success
  end

  test "should get new" do
    get new_hierx_url
    assert_response :success
  end

  test "should create hierx" do
    assert_difference("Hierx.count") do
      post hierxes_url, params: { hierx: { child_id: @hierx.child_id, generaion: @hierx.generaion, parent_id: @hierx.parent_id } }
    end

    assert_redirected_to hierx_url(Hierx.last)
  end

  test "should show hierx" do
    get hierx_url(@hierx)
    assert_response :success
  end

  test "should get edit" do
    get edit_hierx_url(@hierx)
    assert_response :success
  end

  test "should update hierx" do
    patch hierx_url(@hierx), params: { hierx: { child_id: @hierx.child_id, generaion: @hierx.generaion, parent_id: @hierx.parent_id } }
    assert_redirected_to hierx_url(@hierx)
  end

  test "should destroy hierx" do
    assert_difference("Hierx.count", -1) do
      delete hierx_url(@hierx)
    end

    assert_redirected_to hierxes_url
  end
end
