class Course < ApplicationRecord
  belongs_to :department
  has_many :sections, dependent: :destroy
end
