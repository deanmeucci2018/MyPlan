require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { ah_req: @course.ah_req, course_credits: @course.course_credits, course_description: @course.course_description, course_full_name: @course.course_full_name, course_number: @course.course_number, department_id: @course.department_id, l_req: @course.l_req, q_req: @course.q_req, s_req: @course.s_req, sm_req: @course.sm_req, ss_req: @course.ss_req, w_req: @course.w_req } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { ah_req: @course.ah_req, course_credits: @course.course_credits, course_description: @course.course_description, course_full_name: @course.course_full_name, course_number: @course.course_number, department_id: @course.department_id, l_req: @course.l_req, q_req: @course.q_req, s_req: @course.s_req, sm_req: @course.sm_req, ss_req: @course.ss_req, w_req: @course.w_req } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
