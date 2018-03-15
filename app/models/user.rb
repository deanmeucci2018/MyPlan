class User < ApplicationRecord
    has_many :enrolls, dependent: :destroy
    has_many :sections, through: :enrolls
    before_save {self.email = email.downcase}
    validates :student_first_name, presence: true, length: {maximum: 50}
    validates :student_last_name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence: true, length: {maximum: 255},format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, :if => :password #added to allow update of non password attributes

end
