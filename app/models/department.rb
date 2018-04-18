class Department < ApplicationRecord
    has_many :courses, dependent: :destroy
    has_many :interests, dependent: :destroy
    
            has_many :courses_by_course_number, -> { order(:course_number) }, class_name: 'Course'
            #scope :courses_by_course_number, -> { courses.order(course_number: :asc) }

   # scope :courses_by_course_number,  courses.order("course_number ASC")
end
