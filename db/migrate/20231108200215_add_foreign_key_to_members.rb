class AddForeignKeyToMembers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :members, :groups, column: :group_id, on_delete: :cascade
  end
end
