class Department < ApplicationRecord
    has_many :courses, dependent: :destroy
    has_many :interests, dependent: :destroy
end
