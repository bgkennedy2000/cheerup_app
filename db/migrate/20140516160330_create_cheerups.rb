class CreateCheerups < ActiveRecord::Migration
  def change
    create_table :cheerups do |t|
      t.string :image_url
      t.string :state
      t.text :message
      t.integer :user_id

      t.timestamps
    end
  end
end
