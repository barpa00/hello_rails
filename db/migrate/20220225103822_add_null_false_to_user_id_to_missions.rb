class AddNullFalseToUserIdToMissions < ActiveRecord::Migration[7.0]
  def up
    Mission.where(user_id: nil).update_all(user_id: User.first.id)
    change_column_null :missions, :user_id, false
  end

  def down
    change_column_null :missions, :user_id, true
  end
end
