class CreateCourseRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :course_requirements do |t|
      t.references :course, foreign_key: true
      t.references :requirement, foreign_key: true

      t.timestamps
    end
      add_index :course_requirements, [:course_id, :requirement_id]
  end
end
