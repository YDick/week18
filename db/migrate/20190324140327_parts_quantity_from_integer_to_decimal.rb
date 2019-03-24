class PartsQuantityFromIntegerToDecimal < ActiveRecord::Migration[5.2]
  def up
    change_column :parts, :quantity, :decimal
    end

  def down
    change_column :parts, :quantity, :integer
  end

end
