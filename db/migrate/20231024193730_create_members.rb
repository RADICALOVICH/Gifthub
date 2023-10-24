class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :is_admin, default: false

      t.timestamps
    end
  end
end
