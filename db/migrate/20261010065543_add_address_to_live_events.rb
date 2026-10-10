class AddAddressToLiveEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :live_events, :address, :string
  end
end
