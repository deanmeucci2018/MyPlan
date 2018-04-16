class Section < ApplicationRecord
  belongs_to :course
  has_many :enrolls, dependent: :destroy
  has_many :users, through: :enrolls
  
  def section_name
    "#{semester}#{section_year.to_s}#{course.department.dep_short_name}#{course.course_number}#{section_letter}"
  end
  
  def section_exact
    "#{semester}#{section_year.to_s}"
  end
  
  def section_fulltime
    "#{start_time.strftime "%I:%M"} - #{end_time.strftime "%I:%M %p"}"
  end
  
  def section_short
    "#{course.department.dep_short_name}#{course.course_number}#{section_letter}"
  end
  
end
