class CreateUnkaiPhotos < ActiveRecord::Migration
  def change
    create_table :unkai_photos do |t|
      t.text :comment
      t.date :date, :null => false

      t.timestamps null: false
    end
  end
end
