class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.string :requirement_name
      t.string :requirement_type
      t.decimal :courses_towards_requirement
      t.references :interest, foreign_key: true

      t.timestamps
    end
  end
end
