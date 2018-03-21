class CreateStudentInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :student_interests do |t|
      t.decimal :student_interest_credits
      t.references :user, foreign_key: true
      t.references :interest, foreign_key: true

      t.timestamps
    end
     add_index :student_interests, [:user_id, :interest_id]
  end
end
