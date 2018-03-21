class Course < ApplicationRecord
  belongs_to :department
  has_many :sections, dependent: :destroy
  
  has_many :course_requirements, dependent: :destroy
  has_many :requirements, through: :course_requirements
end
