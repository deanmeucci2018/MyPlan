require 'test_helper'

class CourseRequirementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get course_requirements_index_url
    assert_response :success
  end

end
