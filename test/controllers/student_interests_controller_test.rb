require 'test_helper'

class StudentInterestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_interests_index_url
    assert_response :success
  end

end
