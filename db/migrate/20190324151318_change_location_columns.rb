class ChangeLocationColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :city, :string
    add_column :locations, :weather, :string
    remove_column :locations, :name, :string
    remove_column :locations, :address, :string
  end
end
