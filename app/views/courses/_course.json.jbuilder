json.extract! course, :id, :course_number, :course_full_name, :course_description, :course_credits, :q_req, :w_req, :s_req, :ah_req, :l_req, :sm_req, :ss_req, :department_id, :created_at, :updated_at
json.url course_url(course, format: :json)
