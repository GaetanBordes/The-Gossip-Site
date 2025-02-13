class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :city, :string
    add_column :users, :birth_date, :date
    add_column :users, :description, :text
  end
end
