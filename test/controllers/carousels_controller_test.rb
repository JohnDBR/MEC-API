require 'test_helper'

class CarouselsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carousels_index_url
    assert_response :success
  end

  test "should get show" do
    get carousels_show_url
    assert_response :success
  end

  test "should get create" do
    get carousels_create_url
    assert_response :success
  end

  test "should get update" do
    get carousels_update_url
    assert_response :success
  end

  test "should get destroy" do
    get carousels_destroy_url
    assert_response :success
  end

end
