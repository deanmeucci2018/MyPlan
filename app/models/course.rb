class Course < ApplicationRecord
  belongs_to :department
  has_many :sections, dependent: :destroy
  
  has_many :course_requirements, dependent: :destroy
  has_many :requirements, through: :course_requirements
  
  def course_short_name
    "#{department.dep_short_name}#{course_number}"
  end
end
