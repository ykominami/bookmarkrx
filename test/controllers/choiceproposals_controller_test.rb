require "test_helper"

class ChoiceproposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @choiceproposal = choiceproposals(:one)
  end

  test "should get index" do
    get choiceproposals_url
    assert_response :success
  end

  test "should get new" do
    get new_choiceproposal_url
    assert_response :success
  end

  test "should create choiceproposal" do
    assert_difference("Choiceproposal.count") do
      post choiceproposals_url, params: { choiceproposal: { content: @choiceproposal.content, status: @choiceproposal.status } }
    end

    assert_redirected_to choiceproposal_url(Choiceproposal.last)
  end

  test "should show choiceproposal" do
    get choiceproposal_url(@choiceproposal)
    assert_response :success
  end

  test "should get edit" do
    get edit_choiceproposal_url(@choiceproposal)
    assert_response :success
  end

  test "should update choiceproposal" do
    patch choiceproposal_url(@choiceproposal), params: { choiceproposal: { content: @choiceproposal.content, status: @choiceproposal.status } }
    assert_redirected_to choiceproposal_url(@choiceproposal)
  end

  test "should destroy choiceproposal" do
    assert_difference("Choiceproposal.count", -1) do
      delete choiceproposal_url(@choiceproposal)
    end

    assert_redirected_to choiceproposals_url
  end
end
