class AddAasmStateToMissions < ActiveRecord::Migration[7.0]
  def change
    add_column :missions, :aasm_state, :string
  end
end
