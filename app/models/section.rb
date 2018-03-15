class Section < ApplicationRecord
  belongs_to :course
  has_many :enrolls, dependent: :destroy
  has_many :users, through: :enrolls
end
