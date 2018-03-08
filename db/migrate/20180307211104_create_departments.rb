class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :dep_short_name
      t.string :dep_full_name

      t.timestamps
    end
  end
end
