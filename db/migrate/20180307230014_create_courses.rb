class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :course_number
      t.string :course_full_name
      t.text :course_description
      t.decimal :course_credits
      t.boolean :q_req
      t.boolean :w_req
      t.boolean :s_req
      t.boolean :ah_req
      t.boolean :l_req
      t.boolean :sm_req
      t.boolean :ss_req
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
