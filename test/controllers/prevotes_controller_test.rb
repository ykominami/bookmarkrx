require "test_helper"

class PrevotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prevote = prevotes(:one)
  end

  test "should get index" do
    get prevotes_url
    assert_response :success
  end

  test "should get new" do
    get new_prevote_url
    assert_response :success
  end

  test "should create prevote" do
    assert_difference("Prevote.count") do
      post prevotes_url, params: { prevote: {  } }
    end

    assert_redirected_to prevote_url(Prevote.last)
  end

  test "should show prevote" do
    get prevote_url(@prevote)
    assert_response :success
  end

  test "should get edit" do
    get edit_prevote_url(@prevote)
    assert_response :success
  end

  test "should update prevote" do
    patch prevote_url(@prevote), params: { prevote: {  } }
    assert_redirected_to prevote_url(@prevote)
  end

  test "should destroy prevote" do
    assert_difference("Prevote.count", -1) do
      delete prevote_url(@prevote)
    end

    assert_redirected_to prevotes_url
  end
end
