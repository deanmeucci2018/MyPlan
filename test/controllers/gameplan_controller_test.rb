require 'test_helper'

class GameplanControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get gameplan_display_url
    assert_response :success
  end

end
