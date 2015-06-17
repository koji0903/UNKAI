class AddImageToUnkaiPhoto < ActiveRecord::Migration
  def change
    add_column :unkai_photos, :image, :string
  end
end
