class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.time :start_time
      t.time :end_time
      t.string :professor
      t.string :section_letter
      t.string :semester
      t.integer :section_year
      t.string :section_days
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
