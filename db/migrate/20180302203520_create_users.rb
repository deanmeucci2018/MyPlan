class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :student_first_name
      t.string :student_last_name
      t.string :email
      t.integer :grad_year
      t.decimal :total_credits

      t.timestamps
    end
  end
end
