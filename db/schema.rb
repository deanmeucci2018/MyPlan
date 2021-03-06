# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180418213330) do

  create_table "course_requirements", force: :cascade do |t|
    t.integer "course_id"
    t.integer "requirement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "requirement_id"], name: "index_course_requirements_on_course_id_and_requirement_id"
    t.index ["course_id"], name: "index_course_requirements_on_course_id"
    t.index ["requirement_id"], name: "index_course_requirements_on_requirement_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "course_number"
    t.string "course_full_name"
    t.text "course_description"
    t.decimal "course_credits"
    t.boolean "q_req"
    t.boolean "w_req"
    t.boolean "s_req"
    t.boolean "ah_req"
    t.boolean "l_req"
    t.boolean "sm_req"
    t.boolean "ss_req"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "dep_short_name"
    t.string "dep_full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrolls", force: :cascade do |t|
    t.integer "user_id"
    t.integer "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_enrolls_on_section_id"
    t.index ["user_id", "section_id"], name: "index_enrolls_on_user_id_and_section_id"
    t.index ["user_id"], name: "index_enrolls_on_user_id"
  end

  create_table "interests", force: :cascade do |t|
    t.string "interest_name"
    t.string "interest_type"
    t.decimal "total_credits_needed"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requirement_id"
    t.text "description"
    t.index ["department_id"], name: "index_interests_on_department_id"
    t.index ["requirement_id"], name: "index_interests_on_requirement_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.string "requirement_name"
    t.string "requirement_type"
    t.decimal "courses_towards_requirement"
    t.integer "interest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_requirements_on_interest_id"
  end

  create_table "sections", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.string "professor"
    t.string "section_letter"
    t.string "semester"
    t.integer "section_year"
    t.string "section_days"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "student_interests", force: :cascade do |t|
    t.decimal "student_interest_credits"
    t.integer "user_id"
    t.integer "interest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_student_interests_on_interest_id"
    t.index ["user_id", "interest_id"], name: "index_student_interests_on_user_id_and_interest_id"
    t.index ["user_id"], name: "index_student_interests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "student_first_name"
    t.string "student_last_name"
    t.string "email"
    t.integer "grad_year"
    t.decimal "total_credits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
