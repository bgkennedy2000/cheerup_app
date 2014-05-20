class AddImageFileToCheerups < ActiveRecord::Migration
  def change
    add_column :cheerups, :image_file, :string
  end
end
