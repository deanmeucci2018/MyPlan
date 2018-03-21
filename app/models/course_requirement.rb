class CourseRequirement < ApplicationRecord
  belongs_to :course
  belongs_to :requirement
end
