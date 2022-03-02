class CreateMissionsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :missions_tags do |t|
      t.integer :tag_id, null: false, foreign_key: true
      t.integer :mission_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
