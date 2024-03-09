require "test_helper"

class YsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @y = ys(:one)
  end

  test "should get index" do
    get ys_url
    assert_response :success
  end

  test "should get new" do
    get new_y_url
    assert_response :success
  end

  test "should create y" do
    assert_difference("Y.count") do
      post ys_url, params: { y: { name: @y.name } }
    end

    assert_redirected_to y_url(Y.last)
  end

  test "should show y" do
    get y_url(@y)
    assert_response :success
  end

  test "should get edit" do
    get edit_y_url(@y)
    assert_response :success
  end

  test "should update y" do
    patch y_url(@y), params: { y: { name: @y.name } }
    assert_redirected_to y_url(@y)
  end

  test "should destroy y" do
    assert_difference("Y.count", -1) do
      delete y_url(@y)
    end

    assert_redirected_to ys_url
  end
end
