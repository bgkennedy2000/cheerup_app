class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.integer :cheerup_id
      t.string :kind

      t.timestamps
    end
  end
end
