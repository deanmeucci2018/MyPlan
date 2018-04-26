class AddDescriptionToInterests < ActiveRecord::Migration[5.1]
  def change
    add_column :interests, :description, :text
  end
end
