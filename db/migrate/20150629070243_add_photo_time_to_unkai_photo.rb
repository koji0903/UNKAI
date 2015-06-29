class AddPhotoTimeToUnkaiPhoto < ActiveRecord::Migration
  def change
    add_column :unkai_photos, :photo_time, :string
  end
end
