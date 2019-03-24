class ChangeLocationColumnsBack < ActiveRecord::Migration[5.2]
  def change
      remove_column :locations, :city, :string
      remove_column :locations, :weather, :string
      add_column :locations, :name, :string
      add_column :locations, :address, :string
    end
end
