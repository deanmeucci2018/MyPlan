require 'test_helper'

class EnrollsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enrolls_index_url
    assert_response :success
  end

  test "should get new" do
    get enrolls_new_url
    assert_response :success
  end

  test "should get edit" do
    get enrolls_edit_url
    assert_response :success
  end

  test "should get show" do
    get enrolls_show_url
    assert_response :success
  end

  test "should get update" do
    get enrolls_update_url
    assert_response :success
  end

  test "should get destroy" do
    get enrolls_destroy_url
    assert_response :success
  end

end
