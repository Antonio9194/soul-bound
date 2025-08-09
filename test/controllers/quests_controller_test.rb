require "test_helper"

class QuestsControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get quests_dashboard_url
    assert_response :success
  end
end
