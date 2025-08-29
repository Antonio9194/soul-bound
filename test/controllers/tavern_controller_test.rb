require "test_helper"

class TavernControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tavern_index_url
    assert_response :success
  end
end
