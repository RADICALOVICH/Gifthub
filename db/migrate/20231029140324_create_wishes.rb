class CreateWishes < ActiveRecord::Migration[7.0]
  def change
    create_table :wishes do |t|
      t.string :title
      t.string :short_description
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
