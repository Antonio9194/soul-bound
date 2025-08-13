require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get list_items" do
    get store_list_items_url
    assert_response :success
  end

  test "should get show" do
    get store_show_url
    assert_response :success
  end

  test "should get purchase" do
    get store_purchase_url
    assert_response :success
  end
end
