class CreatePartyGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :party_guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :dietary_restrictions
      t.float :salary
      t.integer :no_of_kids
      t.string :vulnerabilities
      t.string :illnesses
      t.string :medication

    end
  end
end
