require "test_helper"

class JourneyControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get journey_new_url
    assert_response :success
  end

  test "should get create" do
    get journey_create_url
    assert_response :success
  end
end
