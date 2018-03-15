class CreateEnrolls < ActiveRecord::Migration[5.1]
  def change
    create_table :enrolls do |t|
      t.references :user, foreign_key: true
      t.references :section, foreign_key: true

      t.timestamps
    end
    add_index :enrolls, [:user_id, :section_id]
  end
end
