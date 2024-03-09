require "test_helper"

class ProposersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proposer = proposers(:one)
  end

  test "should get index" do
    get proposers_url
    assert_response :success
  end

  test "should get new" do
    get new_proposer_url
    assert_response :success
  end

  test "should create proposer" do
    assert_difference("Proposer.count") do
      post proposers_url, params: { proposer: { name: @proposer.name, session: @proposer.session } }
    end

    assert_redirected_to proposer_url(Proposer.last)
  end

  test "should show proposer" do
    get proposer_url(@proposer)
    assert_response :success
  end

  test "should get edit" do
    get edit_proposer_url(@proposer)
    assert_response :success
  end

  test "should update proposer" do
    patch proposer_url(@proposer), params: { proposer: { name: @proposer.name, session: @proposer.session } }
    assert_redirected_to proposer_url(@proposer)
  end

  test "should destroy proposer" do
    assert_difference("Proposer.count", -1) do
      delete proposer_url(@proposer)
    end

    assert_redirected_to proposers_url
  end
end
