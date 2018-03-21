class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.string :interest_name
      t.string :interest_type
      t.decimal :total_credits_needed
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
