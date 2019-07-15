require 'test_helper'

class ProductOptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get product_options_create_url
    assert_response :success
  end

  test "should get destroy" do
    get product_options_destroy_url
    assert_response :success
  end

end
