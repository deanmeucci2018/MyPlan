class Department < ApplicationRecord
    has_many :courses, dependent: :destroy
end
