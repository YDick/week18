class AddVotingPreferencesToPartyGuests < ActiveRecord::Migration[5.2]
  def change
    change_table :party_guests do |t|
      t.string :voting_preferences
    end
  end
end
