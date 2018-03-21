class Interest < ApplicationRecord
  belongs_to :department
  
  has_many :requirements, dependent: :destroy
  has_many :student_interests, dependent: :destroy
  has_many :users, through: :student_interests
  
end
