require "test_helper"

class ParisbisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parisbi = parisbis(:one)
  end

  test "should get index" do
    get parisbis_url
    assert_response :success
  end

  test "should get new" do
    get new_parisbi_url
    assert_response :success
  end

  test "should create parisbi" do
    assert_difference("Parisbi.count") do
      post parisbis_url, params: { parisbi: {  } }
    end

    assert_redirected_to parisbi_url(Parisbi.last)
  end

  test "should show parisbi" do
    get parisbi_url(@parisbi)
    assert_response :success
  end

  test "should get edit" do
    get edit_parisbi_url(@parisbi)
    assert_response :success
  end

  test "should update parisbi" do
    patch parisbi_url(@parisbi), params: { parisbi: {  } }
    assert_redirected_to parisbi_url(@parisbi)
  end

  test "should destroy parisbi" do
    assert_difference("Parisbi.count", -1) do
      delete parisbi_url(@parisbi)
    end

    assert_redirected_to parisbis_url
  end
end
