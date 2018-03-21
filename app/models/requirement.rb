class Requirement < ApplicationRecord
  belongs_to :interest
  has_many :course_requirements, dependent: :destroy
  has_many :courses, through: :course_requirements
end
