class AddOrderToMissions < ActiveRecord::Migration[7.0]
  def change
    add_column :missions, :status, :integer, default: 0
  end
end
