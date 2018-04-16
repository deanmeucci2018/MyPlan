class Interest < ApplicationRecord
  belongs_to :department
  
  has_many :requirements, dependent: :destroy
  has_many :student_interests, dependent: :destroy
  has_many :users, through: :student_interests
  
  def interest_full_name
        "#{interest_name} Type: #{interest_type}"
  end
end
