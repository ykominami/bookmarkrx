require "test_helper"

class PathxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pathx = pathxes(:one)
  end

  test "should get index" do
    get pathxes_url
    assert_response :success
  end

  test "should get new" do
    get new_pathx_url
    assert_response :success
  end

  test "should create pathx" do
    assert_difference("Pathx.count") do
      post pathxes_url, params: { pathx: { idx: @pathx.idx, last_item: @pathx.last_item, path: @pathx.path } }
    end

    assert_redirected_to pathx_url(Pathx.last)
  end

  test "should show pathx" do
    get pathx_url(@pathx)
    assert_response :success
  end

  test "should get edit" do
    get edit_pathx_url(@pathx)
    assert_response :success
  end

  test "should update pathx" do
    patch pathx_url(@pathx), params: { pathx: { idx: @pathx.idx, last_item: @pathx.last_item, path: @pathx.path } }
    assert_redirected_to pathx_url(@pathx)
  end

  test "should destroy pathx" do
    assert_difference("Pathx.count", -1) do
      delete pathx_url(@pathx)
    end

    assert_redirected_to pathxes_url
  end
end
